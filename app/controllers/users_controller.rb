class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :show ]
  before_filter :correct_user?

  def index
    @users = User.paginate(:page => params[:page])
  end

  def edit
    @user = current_user
  end
  
  def update
    if current_user.update_attributes(params[:user])
      redirect_to current_user
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
