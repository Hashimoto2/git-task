class UsersController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to  users_path
    else
      @users = Users.all
      flash.now[:alert] = 'メッセージを入力してください。'
      render "show"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
