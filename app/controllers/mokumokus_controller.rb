class MokumokusController < ApplicationController
  def show
    @mokumoku = Mokumoku.find(params[:id])
    @comments = @mokumoku.comments
    @comment = Comment.new

    current_user&.update_notification_status(@mokumoku)
  end
end
