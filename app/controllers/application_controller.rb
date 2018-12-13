class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  private
  def not_authenticated
    redirect_to login_path, danger: 'ログインしてください。'
  end
end
