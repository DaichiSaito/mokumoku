class NotificationsController < ApplicationController
  before_action :require_login
  def link_through
    @notification = current_user.notifications.find(params[:id])
    @notification.read! if @notification.unread?
    redirect_to mokumoku_path(@notification.mokumoku)
  end
end
