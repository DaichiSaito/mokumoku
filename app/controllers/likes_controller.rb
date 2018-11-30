class LikesController < ApplicationController
  before_action :require_login

  def create
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.like(@mokumoku)
    @mokumoku.notifications.create(user_id: @mokumoku.user.id, notified_by: current_user, notified_type: :like_to_own_mokumoku)
  end
end
