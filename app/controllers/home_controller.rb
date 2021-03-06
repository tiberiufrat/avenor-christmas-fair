class HomeController < ApplicationController
  def index
    @events = Event.where(start: params[:start]..params[:end])
    if admin_signed_in?
      @current_admin_events = current_admin.events
      @current_admin_notifications = current_admin.notifications
    end
  end

  def about
  end
end
