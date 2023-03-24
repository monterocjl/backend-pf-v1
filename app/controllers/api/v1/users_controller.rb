class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def show
    @user_logged = current_user
    render :show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :create
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user_logged = current_user
    if current_user.update(user_params)
      render :update
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
  end

  private
  def user_params
    params.permit(:email, :password, :name, :lastname, :avatar_url)
  end
end