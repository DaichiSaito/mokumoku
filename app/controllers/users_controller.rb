class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def new
    @user = User.new
    @user.favorite_areas.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_url, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザーが作成出来ませんでした'
      render :new
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile, :avatar, :password, :password_confirmation, area_ids: [])
  end
end
