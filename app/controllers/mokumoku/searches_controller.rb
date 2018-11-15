class Mokumoku::SearchesController < ApplicationController
  before_action :require_login

  def index
    @mokumokus = Mokumoku.futures
  end
end
