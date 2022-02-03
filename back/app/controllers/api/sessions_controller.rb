class Api::SessionsController < ApplicationController
  def user
    render json: current_user, status: :ok
  end

  def books
    render json: current_user.books
  end

  def showbook
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
    render json: @book
  end
end
