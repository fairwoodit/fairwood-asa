class ParentsController < ApplicationController
  before_filter :authenticate_parent!
  load_and_authorize_resource

  # GET /parents
  # GET /parents.json
  def index
    authorize! :index, nil
    @parents = Parent.all
  end

  # GET /parents/1
  # GET /parents/1.json
  def show
  end

  # GET /parents/new
  def new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    respond_to do |format|
      if @parent.save
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    if parent_params[:password].blank?
      parent_params.delete(:password)
      parent_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@parent, parent_params)
                             @parent.update(parent_params)
                           else
                             @parent.update_without_password(parent_params)
                           end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
  def needs_password?(_, params)
    params[:password].present?
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit(
        :first_name, :last_name, :email, :password, :password_confirmation,
        :phone_number, :school, :role)
    end
end
