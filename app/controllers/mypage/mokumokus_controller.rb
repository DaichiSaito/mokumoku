class Mypage::MokumokusController < MypageController
  before_action :set_mokumoku, only: %i[edit update]

  def index
    @mokumokus = current_user.mokumokus
  end

  def new
    @mokumoku = Mokumoku.new
  end

  def create
    @mokumoku = current_user.mokumokus.build(mokumoku_params)
    if @mokumoku.save
      redirect_to mypage_root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @mokumoku.update(mokumoku_params)
      redirect_to mypage_root_path
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
end
