class Mypage::MailNotificationsController < MypageController
  before_action :set_user
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_root_path, success: 'メール通知設定を更新しました。'
    else
      flash.now[:danger] = 'メール通知設定を更新できませんでした。'
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:mail_receive)
  end
end
