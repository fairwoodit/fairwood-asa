class StudentsController < ApplicationController
  before_filter :authenticate_parent!
  load_and_authorize_resource

  layout 'home'

  # GET /students
  # GET /students.json
  def index
    @students = current_parent.students.by_name
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student.parent = current_parent

    respond_to do |format|
      if @student.save
        format.html { redirect_to action: :index, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to action: :index, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    # Parse the student data
    student_data = params[:student_data] ? params[:student_data].read : ''

    # TODO: Update this to work in world with Parent objects.
    # row_count    = 0
    # Student.transaction do
    #   student_data.split(/[\r\n]/).each do |row|
    #     next if row.blank?
    #     row_count += 1
    #
    #     # Skip the header row (e.g. first row) in the data
    #     next if row_count == 1
    #
    #     student_last, student_first, grade, mother_email, father_email,
    #         teacher_title, teacher_last, teacher_first = row.split(',')[0..7]
    #
    #     # Find or create the Student
    #     student        = load_student(student_first, student_last)
    #     student.grade  = grade if grade.present?
    #
    #     # Aggregate the e-mail addresses.
    #     student.add_email(mother_email)
    #     student.add_email(father_email)
    #
    #     # Find or create the teacher
    #     teacher        = load_teacher(teacher_first, teacher_last)
    #     teacher.title  = teacher_title if teacher_title.present?
    #
    #     # Wire things up!
    #     student.teacher = teacher
    #
    #     # Save one and all! We're probably being overly conservative here...
    #     student.save!
    #     teacher.save!
    #   end
    # end
    redirect_to students_url, notice: "#{row_count - 1} student records created."
  end

  # @return [Student]
  def load_student(student_first, student_last)
    find_or_instantiate(Student, student_last, student_first)
  end

  # @return [Teacher]
  def load_teacher(teacher_first, teacher_last)
    find_or_instantiate(Teacher, teacher_last, teacher_first)
  end

  def search
    # Search for students based on full-names and last-names that start with the search term.

    search_for = "#{params[:term]}%"
    @matches   = Student.where('full_name ilike ? or last_name ilike ?', search_for, search_for).limit(10).order("last_name, first_name").pluck(:full_name)
    render json: @matches
  end

  private

  def find_or_instantiate(klass, last_name, first_name)
    klass.find_by(last_name: last_name, first_name: first_name) ||
        klass.new(last_name: last_name, first_name: first_name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :parent_id, :grade, :teacher_id)
  end
end
