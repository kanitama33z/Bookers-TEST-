class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  def after_log_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(resource)
  end
  
  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully"
    user_path(resource)
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully"
    root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
   
  end
end