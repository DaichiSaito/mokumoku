class Users::OauthsController < GeneralController
  skip_before_action :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = :twitter

    if params[:denied].present?
      logger.error('authenticate denied')
      return redirect_to new_user_url
    end

    begin
      @user = login_from(provider)
      return redirect_to root_path if @user.present?
    rescue OAuth::Unauthorized => e
      logger.error(e)
      return redirect_to root_path
    end

    # see create_from() https://github.com/NoamB/sorcery/blob/master/lib/sorcery/controller/submodules/external.rb
    sorcery_fetch_user_hash provider
    @user = User.new(user_attrs(@provider.user_info_mapping, @user_hash))
    @user.favorite_areas.build

    reset_session # protect from session fixation attack

    render :new
  end

  def new
    # see create_from() https://github.com/NoamB/sorcery/blob/master/lib/sorcery/controller/submodules/external.rb
    sorcery_fetch_user_hash provider
    @user = User.new(user_attrs(@provider.user_info_mapping, @user_hash))
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
