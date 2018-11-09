class Mypage::MokumokusController < MypageController
  def index
    @mokumokus = current_user.mokumokus.all
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

  def edit
    @mokumoku = current_user.mokumokus.find(params[:id])
  end

  def update
    @mokumoku = current_user.mokumokus.find(params[:id])
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
end
