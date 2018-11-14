class TopsController < ApplicationController
  def index
    @mokumokus = Mokumoku.futures
  end
end
