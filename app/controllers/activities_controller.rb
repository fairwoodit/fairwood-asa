class ActivitiesController < ApplicationController
  load_and_authorize_resource

  # GET /activities
  # GET /activities.json
  def index
    if current_parent.students.empty?
      redirect_to students_path, alert: 'Please add a student to your account.'
    else
      @activities = current_parent.admin? ? Activity.order(:name).all :
        Activity.order(:name).visible
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    session[:current_activity_path] = activity_path(@activity)
  end

  # GET /activities/new
  def new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:activity).permit(:name, :instructor, :cost, :description,
                                     :start, :end, :times, :min_seats, :max_seats,
                                     :visible, :cash_only, :min_grade, :max_grade, :category)
  end
end
