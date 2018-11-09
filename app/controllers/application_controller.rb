class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :select_layout

  private

  def select_layout
    return 'before_login' if current_user.blank?

    'application'
  end
end
