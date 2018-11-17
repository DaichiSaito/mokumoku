class Mokumoku::SearchesController < ApplicationController
  before_action :require_login

  def index
    @q = Mokumoku.futures
                 .recent_opens
                 .ransack(like_area_in: current_user.like_areas.pluck(:id))
    @mokumokus = @q.result(distinct: true)
  end
end
