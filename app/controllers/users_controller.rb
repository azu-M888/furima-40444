class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def show
    @user = User.find(params[:id])
    @items = @user.items
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email,:encrypted_password,:last_name,:first_name,:last_name_kana,:first_name_kana,:birth_date)
  end
end
