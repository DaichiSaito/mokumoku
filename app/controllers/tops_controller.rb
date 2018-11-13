class TopsController < GeneralController
  skip_before_action :require_login, only: %i[index]

  def index
    @mokumokus = Mokumoku.futures
  end
end
