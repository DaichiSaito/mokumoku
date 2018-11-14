class MokumokusController < ApplicationController
  def show
    @mokumoku = Mokumoku.find(params[:id])
    @comments = @mokumoku.comments
    @comment = Comment.new
  end
end
