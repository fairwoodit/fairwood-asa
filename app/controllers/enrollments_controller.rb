class EnrollmentsController < ApplicationController
  include EnrollmentsHelper

  before_filter :authenticate_parent!
  load_and_authorize_resource

  # GET /enrollments
  # GET /enrollments.json
  def index
    # Break up current and past enrollments into two groups.
    @current_enrollments, @past_enrollments =
        current_parent.enrollments.lifo.partition { |e| e.activity.season == Season.last }
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  def success
  end

  def waiting_list
  end

  def low_income
  end

  # GET /enrollments/new
  def new
    if current_parent.students.empty?
      redirect_to(students_path,
                  notice: 'You must create a student before enrolling in activities')
    else
      @enrollment.activity_id = params[:activity_id]
      @waiting = params[:waiting]

      @eligible_students = find_eligible_students
      if @eligible_students.empty?
        redirect_to(root_path,
                    notice: 'All of your eligible students are already registered ' +
                      'for this activity.')
      end
    end
  end

  # GET /enrollments/1/edit
  def edit
    @eligible_students = find_eligible_students
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    respond_to do |format|
      if @enrollment.save
        format.html {
          if @enrollment.low_income
            UserMailer.low_income_enrollment_email(@enrollment).deliver_later
            redirect_to enrollment_low_income_path(@enrollment.id)
          elsif is_waiting(@enrollment)
            UserMailer.waiting_list_email(@enrollment).deliver_later
            redirect_to enrollment_waiting_list_path(@enrollment.id)
          else
            UserMailer.enrolled_email(@enrollment).deliver_later
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
      orig_payment_type = @enrollment.payment_type
      if @enrollment.update(enrollment_params)
        if params[:enrollment][:payment_type] != 'none' &&
          params[:enrollment][:payment_type] != orig_payment_type
          # Send a mail to the user confirming payment
          UserMailer.payment_confirmed_email(@enrollment, is_waiting(@enrollment)).deliver_later
        end

        format.html { redirect_to session[:current_activity_path], notice: 'Enrollment was successfully updated.' }
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
      format.html { redirect_to session[:current_activity_path],
                                notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def do_cancel
    respond_to do |format|
      UserMailer.cancel_email(@enrollment).deliver_later
      UserMailer.user_cancel_email(@enrollment).deliver_later
      format.html { redirect_to action: :cancel }
      format.json { render :show, status: :created, location: @enrollment }
    end
  end

  def cancel
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def enrollment_params
    params.require(:enrollment).permit(:activity_id, :student_id, :low_income, :committed, :payment_type)
  end

  def find_eligible_students
    # Get the list of students belonging to the logged-in user who are eligible
    # for the activity (A).
    # Find all students already enrolled for the activity (B).
    # A-B is the set of students who haven't yet enrolled. However, if we're
    # editing an enrollment, we want to include the current registrant in our list,
    # so add that back in.
    activity = @enrollment.activity
    eligible_students = current_parent.students.eligible(activity.min_grade,
                                                         activity.max_grade)
    (eligible_students - activity.students + [@enrollment.student]).
      compact.sort.uniq
  end
end
