class AttendsController < ApplicationController
  before_action :require_login
  def create
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.attend(@mokumoku)
    @mokumoku.notifications.create(user_id: @mokumoku.user.id, notified_by: current_user, notified_type: :attend_mokumoku)
    redirect_to mokumoku_path(@mokumoku)
  end

  def destroy
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.leave(@mokumoku)
    redirect_to mokumoku_path(@mokumoku)
  end
end
