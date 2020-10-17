class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @search = Student.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @students = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @student
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    @student.save!

    respond_to do |format|
      format.html { redirect_to @student, notice: 'Student was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @student.update!(student_params)
    respond_to do |format|
      format.html { redirect_to @student, notice: 'Student was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:balance, :first_name, :last_name, :grade_id)
    end
end
