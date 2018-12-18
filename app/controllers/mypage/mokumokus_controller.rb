class Mypage::MokumokusController < MypageController
  before_action :set_mokumoku, only: %i[edit update show]
  after_action :create_notifications, only: [:create]

  def futures
    @mokumokus = current_user.attending_including_own.futures
    render :index
  end

  def pasts
    @mokumokus = current_user.attending_including_own.pasts
    render :index
  end

  def new
    @mokumoku = Mokumoku.new
  end

  def create
    @mokumoku = current_user.mokumokus.build(mokumoku_params)
    if @mokumoku.save
      redirect_to mypage_mokumoku_url(@mokumoku), success: 'もくもくを作成しました。'
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @mokumoku.update(mokumoku_params)
      redirect_to mypage_root_path, success: 'もくもくを更新しました。'
    else
      render :edit
    end
  end

  private
    def mokumoku_params
      params.require(:mokumoku).permit(:title, :body, :open_at, :area_id)
    end

    def set_mokumoku
      @mokumoku = current_user.mokumokus.find(params[:id])
    end

    def create_notifications
      return unless @mokumoku.persisted?
      users_of_this_area_excluding_self = @mokumoku.area.users.reject { |user| user.id == current_user.id }
      users_of_this_area_excluding_self.each do |user|
        @mokumoku.notifications.create(user_id: user.id, notified_by: current_user, notified_type: :favorite_area_created)
        NotificationMailer.send_favorite_areas_user(user, @mokumoku).deliver_later if user.mail_receive?
      end
    end
end
