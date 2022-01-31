class Api::SessionsController < ApplicationController
  def user
    render json: current_user, status: :ok
  end
end
