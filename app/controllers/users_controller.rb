class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :destroy]
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
      flash[:notice] = "You have creatad book successfully."
      redirect_to  users_path
    else
      @users = Users.all
      flash.now[:alert] = 'メッセージを入力してください。'
      render "show"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      render "edit"
    end
  end

  def destroy
    @user.destroy
      flash[:notice] = "Signed out successfully."
      redirect_to destroy_user_session_path
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
