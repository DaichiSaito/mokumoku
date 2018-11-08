class UsersController < GeneralController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_url, success: t('users.flash.create.success')
    else
      flash.now[:danger] = t('users.flash.create.fail')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :avatar, :password, :password_confirmation)
  end
end
