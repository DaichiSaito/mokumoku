class TopsController < ApplicationController
  def index
    @mokumokus = Mokumoku.futures.recent_opens.page params[:page]
    @mokumokus_past = Mokumoku.pasts.limit(8)
  end

  def term; end
end
