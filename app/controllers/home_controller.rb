class HomeController < ApplicationController
  def index
  	@events = Event.where(start: params[:start]..params[:end])
  end

  def about
  end
end
