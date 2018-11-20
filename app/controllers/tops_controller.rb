class TopsController < ApplicationController
  def index
    @mokumokus = Mokumoku.futures
    @mokumokus_past = Mokumoku.pasts.limit(8)
  end

  def term; end
end
