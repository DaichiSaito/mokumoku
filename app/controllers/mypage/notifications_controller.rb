class Mypage::NotificationsController < MypageController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def link_through
    @notification = current_user.notifications.find(params[:id])
    @notification.read! if @notification.unread?
    redirect_to mokumoku_path(@notification.mokumoku)
  end
end
