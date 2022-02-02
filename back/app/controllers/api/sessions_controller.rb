class Api::SessionsController < ApplicationController
  def user
    render json: current_user, status: :ok
  end

  def books
    render json: current_user.books
  end
end
