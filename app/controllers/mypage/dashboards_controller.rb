class Mypage::DashboardsController < MypageController
  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end

  def schedule
    mokumokus = current_user.attending_including_own.date_range(Time.at(params[:start].to_i), Time.at(params[:end].to_i))
    attending = mokumokus.map do |mokumoku|
      {
        title: mokumoku.title,
        start: mokumoku.open_at.to_s[0, 10], # '2018-11-18'の形式で取得したい
        url: mokumoku_path(mokumoku)
      }
    end
    render json: { events: attending }
  end
end
