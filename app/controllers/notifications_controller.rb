class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show edit update destroy ]

  def index
    @search = Notification.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @notifications = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @notification
  end

  def new
    @notification = Notification.new
  end

  def edit
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.save!

    respond_to do |format|
      format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @notification.update!(notification_params)
    respond_to do |format|
      format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_admin_notifications
    current_admin.notifications.destroy_all
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Notifications were successfully destroyed.' }
      format.js
    end
  end

  def read_notifications
    current_admin.notifications.update_all(read: true)
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Notifications were successfully read."}
      format.js
    end
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:admin_id, :text, :color, :icon, :link, :read)
    end
end
