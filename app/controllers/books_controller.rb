class BooksController < ApplicationController
  def index
    @books = Book.all
    @booknew = Book.new
    @user = User.find(current_user.id)
  end

  def new
    @booknew = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
      if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:succes] = 'You have updated book successfully.'
      redirect_to book_path(@book)
     else
      render :edit
     end
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      flash[:succes] = 'You have created book successfully.'
      redirect_to book_path(@booknew)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      # @book = Book.new
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
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
