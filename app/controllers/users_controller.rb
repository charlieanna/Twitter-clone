class UsersController < ApplicationController
  def followings

  end

  def followers

  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
