class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comments = @book.book_comments
    if @book_comment.save
    else
        render 'form'
    end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    @book_comment.destroy
    if @book_comment.user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
