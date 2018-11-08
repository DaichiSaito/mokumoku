class UserSessionsController < GeneralController
  skip_before_action :require_login, except: %i[destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_url, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログイン出来ませんでした'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_url, success: 'ログアウトしました'
  end
end
