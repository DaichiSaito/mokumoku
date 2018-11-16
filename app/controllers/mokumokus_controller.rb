class MokumokusController < ApplicationController
  def show
    @mokumoku = Mokumoku.find(params[:id]).decorate
    @comments = @mokumoku.comments
    @comment = Comment.new
  end
end
