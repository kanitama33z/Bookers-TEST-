class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :show]

  before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = @book.user
  end
  
  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @user = current_user
    @users = @book.user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      @users = @book.user
      render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id.to_i != current_user.id
      redirect_to books_path
    end
  end

end
