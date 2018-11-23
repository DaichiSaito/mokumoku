class TopsController < ApplicationController
  def index
    @mokumokus = Mokumoku.futures.recent_opens.page params[:page]
    @mokumokus_past = Mokumoku.pasts.limit(8)
    @mokumokus_new_arrivals = Mokumoku.new_arrivals.limit(4)
  end

  def term; end
end
