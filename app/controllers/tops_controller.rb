class TopsController < ApplicationController
  def index
    @mokumokus = Mokumoku.futures.recent_opens.page params[:page]
    @mokumokus_past = Mokumoku.pasts.recent_closed.limit(8)
    @mokumokus_new_arrivals = Mokumoku.futures.new_arrivals.limit(4)
  end

  def term; end
end
