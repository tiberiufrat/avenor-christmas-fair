class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  def index
    @search = Job.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @jobs = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @job
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.save!

    respond_to do |format|
      format.html { redirect_to @job, notice: 'Job was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @job.update!(job_params)
    respond_to do |format|
      format.html { redirect_to @job, notice: 'Job was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:name)
    end
end
