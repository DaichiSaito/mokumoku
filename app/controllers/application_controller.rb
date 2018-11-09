class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :select_layout

  private

  def select_layout
    current_user.blank? ? 'before_login' : 'application'
  end
end
