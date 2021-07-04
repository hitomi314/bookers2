class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
     if comment.save
        redirect_back(fallback_location: root_path)
    else
        @book = book
        @booknew = Book.new
        @user = @book.user
        @book_comment = comment
        render 'books/show'
    end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @book_comment.destroy
    redirect_back(fallback_location: root_path)
    if @book_comment.user != current_users
      redirect_to user_path(current_user.id)
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
