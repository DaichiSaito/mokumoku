class AttendsController < ApplicationController
  before_action :require_login
  def create
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.attend(@mokumoku)
    redirect_to mokumoku_path(@mokumoku)
  end

  def destroy
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    current_user.leave(@mokumoku)
    redirect_to mokumoku_path(@mokumoku)
  end
end
