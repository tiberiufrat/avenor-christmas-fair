class HomeController < ApplicationController
  def index
  	@events = Event.where(start: params[:start]..params[:end])
    @current_admin_events = current_admin.events
  end

  def about
  end
end
