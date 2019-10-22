class UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: %i[show update destroy adminize]

  # GET /users
  def index
    @users = User.where(query_params).page(page).per(per_page)

    render json: serialize('User', @users)
  end

  # GET /users/1
  def show
    render json: serialize('User', @user)
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: serialize('User', @user)
    else
      render json: ame_serialize(@user.errors), status: :unprocessable_entity
    end
  end

  def adminize
    if @user.update(type: 'Admin')
      render json: serialize('User', @user)
    else
      render json: ame_serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def query_params
    queries.permit(:email)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    attributes.permit(:password)
  end
end
