class Mokumokus::SearchController < ApplicationController
  before_action :require_login

  def index
    @q = Mokumoku.futures
                 .recent_opens
                 .ransack(area_id_in: current_user.like_areas.pluck(:id))
    @mokumokus = @q.result(distinct: true).page(params[:page])
  end
end
