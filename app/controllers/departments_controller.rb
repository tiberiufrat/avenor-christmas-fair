class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy ]

  def index
    @search = Department.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @departments = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @department
    @search = Volunteer.reverse_chronologically.ransack(params[:q])
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    @department.save!

    respond_to do |format|
      format.html { redirect_to @department, notice: 'Department was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @department.update!(department_params)
    respond_to do |format|
      format.html { redirect_to @department, notice: 'Department was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name)
    end
end
