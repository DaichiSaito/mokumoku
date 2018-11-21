class Development::UsersController < ApplicationController
  def new
    @user = User.new
    @user.favorite_areas.build
  end

  def create
    @user = User.new(user_params)
    @user.assign_attributes(screen_name: @user.name)
    if @user.save
      redirect_to root_url, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザーが作成出来ませんでした'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :avatar, :password, :password_confirmation, like_area_ids: [])
  end
end
