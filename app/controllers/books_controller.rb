class BooksController < ApplicationController
  def index
    @books = Book.all
    @book_new = Book.new
    @user = User.find(current_user.id)
  end

  def new
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:succes] = 'Book was successfully updated.'
      redirect_to book_path(@book)
     else
      render :edit
     end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:succes] = 'Book was successfully created.'
      redirect_to book_path(id: current_user)
    else
      @books = Book.all
      # @book = Book.new
      render :index
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

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
