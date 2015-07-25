class EnrollmentsController < ApplicationController
  layout 'paneled', only: [:new, :edit]

  load_and_authorize_resource

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = current_parent.enrollments.lifo
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  def success
  end

  def low_income
  end

  # GET /enrollments/new
  def new
    @enrollment.activity_id = params[:activity_id]
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    respond_to do |format|
      if @enrollment.save
        format.html {
          if @enrollment.low_income
            redirect_to enrollment_low_income_path(@enrollment.id)
          else
            redirect_to enrollment_success_path(@enrollment.id)
          end
        }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollments_path, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def enrollment_params
    params.require(:enrollment).permit(:activity_id, :student_id, :low_income, :committed, :paid)
  end
end
