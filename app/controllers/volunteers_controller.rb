class VolunteersController < ApplicationController
  before_action :set_volunteer, only: %i[ show edit update destroy ]

  def index
    @search = Volunteer.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @volunteers = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @volunteer
  end

  def new
    @volunteer = Volunteer.new
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(first_name: params[:volunteer][:first_name], last_name: params[:volunteer][:last_name], grade_id: params[:volunteer][:grade_id], email: params[:volunteer][:email], phone: params[:volunteer][:phone])
    params[:volunteer][:jobs].each do |job_id|
      if job_id != nil && job_id != ""
        @volunteer.jobs.push(Job.find(job_id))
        puts Job.find(job_id).name
      end
    end

    params[:volunteer][:departments].each do |department_id|
      if department_id != nil && department_id != ""
        @volunteer.departments.push(Department.find(department_id))
        puts Department.find(department_id).name
      end
    end

    params[:volunteer][:stands].each do |stand_id|
      if stand_id != nil && stand_id != ""
        @volunteer.stands.push(Stand.find(stand_id))
        puts Stand.find(stand_id).name
      end
    end

    @volunteer.save!

    respond_to do |format|
      format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @volunteer.update!(first_name: params[:volunteer][:first_name], last_name: params[:volunteer][:last_name], grade_id: params[:volunteer][:grade_id], email: params[:volunteer][:email], phone: params[:volunteer][:phone])

    @volunteer.jobs = []
    @volunteer.departments = []
    @volunteer.stands = []

    params[:volunteer][:jobs].each do |job_id|
      if job_id != nil && job_id != ""
        @volunteer.jobs.push(Job.find(job_id))
        puts Job.find(job_id).name
      end
    end

    params[:volunteer][:departments].each do |department_id|
      if department_id != nil && department_id != ""
        @volunteer.departments.push(Department.find(department_id))
        puts Department.find(department_id).name
      end
    end

    params[:volunteer][:stands].each do |stand_id|
      if stand_id != nil && stand_id != ""
        @volunteer.stands.push(Stand.find(stand_id))
        puts Stand.find(stand_id).name
      end
    end

    respond_to do |format|
      format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url, notice: 'Volunteer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    def volunteer_params
      params.require(:volunteer).permit!
    end
end
