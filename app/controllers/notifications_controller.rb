class NotificationsController < ApplicationController
  before_action :require_login
  def link_through
    @notification = current_user.notifications.find(params[:id])
    @notification.read! if @notification.unread?
    redirect_to @notification.notifiable.notification_link
  end
end
