class Walkathon::PaymentsController < ApplicationController
  before_filter :authenticate_parent!

  before_action :set_walkathon_payment, only: [:show, :edit, :update, :destroy]
  before_action :set_walkathon_pledge, only: [:new, :create, :destroy]

  layout 'walkathon'

  # GET /walkathon/payments
  # GET /walkathon/payments.json
  def index
    authorize! :index, Walkathon::Pledge.new
    @pledge = Walkathon::Pledge.find(params[:pledge_id]) if params[:pledge_id]
    @walkathon_payments = params[:pledge_id] ? Walkathon::Payment.for_pledge(params[:pledge_id]) : Walkathon::Payment.all
  end

  # GET /walkathon/payments/1
  # GET /walkathon/payments/1.json
  def show
    authorize! :show, @walkathon_payment
  end

  # GET /walkathon/payments/new
  def new
    @walkathon_payment = Walkathon::Payment.new
    authorize! :new, @walkathon_payment
  end

  # GET /walkathon/payments/1/edit
  def edit
    authorize! :edit, @walkathon_payment
  end

  # POST /walkathon/payments
  # POST /walkathon/payments.json
  def create
    @walkathon_payment = Walkathon::Payment.new(walkathon_payment_params)

    payment_saved = false

    authorize! :create, @walkathon_payment

    Walkathon::Payment.transaction do
      @walkathon_payment.walkathon_pledge = @walkathon_pledge
      payment_saved = @walkathon_payment.save
      raise ActiveRecord::Rollback unless payment_saved
      @walkathon_pledge.paid_amount ||= 0
      @walkathon_pledge.paid_amount += @walkathon_payment.amount
      @walkathon_pledge.save!
    end

    respond_to do |format|
      if payment_saved
        format.html { redirect_to walkathon_payments_path, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @walkathon_payment }
      else
        format.html { render :new }
        format.json { render json: @walkathon_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /walkathon/payments/1
  # PATCH/PUT /walkathon/payments/1.json
  def update
    # TODO: Fix this if we want to support editing payments.
    raise 'The update action is not implemented correctly'

    authorize! :update, @walkathon_payment
    respond_to do |format|
      if @walkathon_payment.update(walkathon_payment_params)
        format.html { redirect_to @walkathon_payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @walkathon_payment }
      else
        format.html { render :edit }
        format.json { render json: @walkathon_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /walkathon/payments/1
  # DELETE /walkathon/payments/1.json
  def destroy
    authorize! :destroy, @walkathon_payment
    Walkathon::Payment.transaction do
      @walkathon_pledge.paid_amount -= (@walkathon_payment.amount || 0)
      payment_destroyed = @walkathon_payment.destroy
      raise ActiveRecord::Rollback unless payment_destroyed
      @walkathon_pledge.save!
    end
    respond_to do |format|
      format.html { redirect_to walkathon_payments_path, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_walkathon_payment
    @walkathon_payment = Walkathon::Payment.find(params[:id])
  end

  def set_walkathon_pledge
    @walkathon_pledge = Walkathon::Pledge.find(params[:pledge_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def walkathon_payment_params
    params.require(:walkathon_payment).permit(:description, :amount, :walkathon_pledge_id)
  end
end
