class Users::OauthsController < GeneralController
  skip_before_action :require_login
  before_action :set_provider_name, only: %i[callback new]

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    return denied_app_collaborate if params[:denied].present?

    begin
      @user = login_from(@provider_name)
      return redirect_to root_path if @user.present?
    rescue OAuth::Unauthorized => e
      logger.error(e)
      return redirect_to root_path
    end

    setup_user_instance @provider_name
    render :new
  end

  def new
    setup_user_instance @provider_name
  end

  def create
    @user = User.new(user_params)
    @user.download_and_attach_avatar

    # new アクションで実行した create_and_validate_from() の中でセッションに保存したパラメータを取得し、認証クラスの生成に用いる
    # （add_provider_to_user() で生成する方法は「401 Authorization Required」が解決出来なかった）
    @user.authentications.build(session[:incomplete_user]['provider'])

    if @user.save
      reset_session # protect from session fixation attack
      auto_login(@user)
      redirect_to root_url, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザーが作成出来ませんでした'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image_url, :avatar, :password, :password_confirmation, favorite_areas_attributes: [:area_id])
  end

  # アプリ連携を拒否
  def denied_app_collaborate
    logger.error('authenticate denied')
    return redirect_to new_user_url
  end

  def setup_user_instance(provider_name)
    # see https://github.com/NoamB/sorcery/blob/master/lib/sorcery/controller/submodules/external.rb
    @user = create_and_validate_from provider_name
    @user.favorite_areas.build
  end

  # TODO: Twitter で決め打ち指定
  # Twitter 認証のコールバックでクエリ文字を含めることが出来ず、
  # oauth/request_tokenリクエストが必要になるようなので、ひとまず決め打ち指定で実装
  def set_provider_name
    @provider_name = :twitter
  end
end
