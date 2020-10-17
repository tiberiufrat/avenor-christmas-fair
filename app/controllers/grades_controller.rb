class GradesController < ApplicationController
  before_action :set_grade, only: %i[ show edit update destroy ]

  def index
    @search = Grade.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @grades = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @grade
  end

  def new
    @grade = Grade.new
  end

  def edit
  end

  def create
    @grade = Grade.new(grade_params)
    @grade.save!

    respond_to do |format|
      format.html { redirect_to @grade, notice: 'Grade was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @grade.update!(grade_params)
    respond_to do |format|
      format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_grade
      @grade = Grade.find(params[:id])
    end

    def grade_params
      params.require(:grade).permit(:name)
    end
end
