class StandsController < ApplicationController
  before_action :set_stand, only: %i[ show edit update destroy ]

  def index
    @search = Stand.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @stands = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @stand
  end

  def new
    @stand = Stand.new
  end

  def edit
  end

  def create
    @stand = Stand.new(stand_params)
    @stand.save!

    respond_to do |format|
      format.html { redirect_to @stand, notice: 'Stand was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @stand.update!(stand_params)
    respond_to do |format|
      format.html { redirect_to @stand, notice: 'Stand was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @stand.destroy
    respond_to do |format|
      format.html { redirect_to stands_url, notice: 'Stand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_stand
      @stand = Stand.find(params[:id])
    end

    def stand_params
      params.require(:stand).permit(:name)
    end
end
