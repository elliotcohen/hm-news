class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :show ]
  before_filter :correct_user?

  def index
    @users = User.paginate(:page => params[:page])
  end

  def edit
    @user = User.where(:_id => current_user.id).first
  end
  
  def update
    @user = User.where(:_id => current_user.id).first
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
