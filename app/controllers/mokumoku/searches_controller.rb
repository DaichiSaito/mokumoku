class Mokumoku::SearchesController < ApplicationController
  before_action :require_login

  def index
    @q = Mokumoku.futures
                 .recent_opens
                 .ransack(area_id_in: current_user.areas.pluck(:id))
    @mokumokus = @q.result(distinct: true)
  end
end
