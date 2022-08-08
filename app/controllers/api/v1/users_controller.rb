class Api::V1::UsersController < ApplicationController

  def profile
   render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  #get /Users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  #get /users/id
  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  #post /users

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.full_messages},
      status: :unprocessable_entity
    end
  end


  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_messages},
        status: :unprocessable_entity
    end
  end

  #delete /users/id
  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
