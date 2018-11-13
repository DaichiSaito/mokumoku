class Mypage::UsersController < MypageController
  before_action :set_user

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_user_path, success: 'プロフィールを更新しました'
    else
      flash.now[:danger] = 'プロフィールを更新出来ませんでした'
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile, :avatar, :password, :password_confirmation, favorite_areas_attributes: [:area_id, :id])
  end
end
