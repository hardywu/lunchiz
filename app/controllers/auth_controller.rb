class AuthController < ApplicationController
  before_action :set_new_user, only: :signup
  before_action :authorize, only: :me

  def signin
    @user = User.find_by email: params[:email]
    raise AuthFailed unless @user&.authenticate params[:password]

    response.headers['Authorization'] = "Bearer #{@user.jwt}"
    render json: serialize('User', @user), status: :ok
  end

  def signup
    if @user.save
      response.headers['Authorization'] = "Bearer #{@user.jwt}"
      render json: serialize('User', @user), status: :created
    else
      render json: ame_serialize(@user.errors),
             status: :unprocessable_entity
    end
  end

  def me
    render json: serialize('User', current_user)
  end

  def set_new_user
    klass = params[:type] == 'owner' ? Owner : User
    @user = klass.new email: params[:email], password: params[:password]
  end
end
