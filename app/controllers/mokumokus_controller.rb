class MokumokusController < ApplicationController
  def show
    @mokumoku = Mokumoku.find(params[:id])
  end
end
