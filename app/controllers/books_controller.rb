class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      flash.now[:alert] = 'メッセージを入力してください。'
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user!= current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      flash.now[:alert] = 'メッセージを入力してください。'
      render "edit"
    end
  end

  def destroy
    Book.find_by(params[:id]).destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
