class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @search = Student.reverse_chronologically.ransack(params[:q])
    respond_to do |format|
      format.js
      format.any(:html, :json) { @students = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @student
  end

  def new
    if params[:grade]
      grade = Grade.find(params[:grade])
      @student = grade.students.build
    else
      @student = Student.new
    end
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
      format.js
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_money
    if params[:change_money]
      @student = Student.find(params[:id])
      puts @student.name
      @student.change_money(params[:change_money].to_i, params[:operation])
      puts "New balance: #{@student.balance}"
      respond_to do |format|
        format.js
      end
    end
  end
 
  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:balance, :first_name, :last_name, :grade_id, :id, :change_money, :operation)
    end
end
