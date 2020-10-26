class BooksController < ApplicationController


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
      redirect_to book_path(@book), notice: `You have creatad book successfully.`
    else
      @books = Book.all
      flash.now[:alert] = 'メッセージを入力してください。'
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: `You have updated book successfully.`
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
    params.require(:book).permit(:title, :opinion)
  end

end
