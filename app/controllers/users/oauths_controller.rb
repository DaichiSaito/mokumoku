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
      return redirect_to root_path
    end

    @user = login_from(provider)
    if @user.present?
      redirect_to root_path
    else
      begin
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path
      rescue StandardError => e
        logger.error(e)
        redirect_to root_path
      end
    end
  end
end
