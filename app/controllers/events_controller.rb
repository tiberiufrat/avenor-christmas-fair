class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @event = Event.new
    @search = Event.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @events = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @event
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.admin ||= current_admin
    @event.save!

    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event was successfully created.' }
      format.json { render :show, status: :created }
      format.js
    end
  end

  def update
    @event.update!(event_params)
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      format.json { render :show }
      format.js
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :color, :start, :date_range, :end, :all_day, :admin_id)
    end
end
