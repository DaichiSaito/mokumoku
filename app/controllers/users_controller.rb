class UsersController < GeneralController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
    @user.favorite_areas.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_url, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザーが作成出来ませんでした'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :avatar, :password, :password_confirmation, favorite_areas_attributes: [:area_id])
  end
end
