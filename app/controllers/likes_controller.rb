class LikesController < ApplicationController
  before_action :require_login

  def create
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.like(@mokumoku)
    # TODO: notify
    # @mokumoku.notifications.create(user_id: @mokumoku.user.id, notified_by: current_user, notified_type: :attend_mokumoku)
  end

  def destroy
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.not_like(@mokumoku)
  end
end
