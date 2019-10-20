class AuthController < ApplicationController
  def signin
    @user = User.find_by email: params[:email]
    raise AuthFailed unless @user&.authenticate params[:password]

    response.headers['Authorization'] = "Bearer #{@user.jwt}"
    render json: serialize('User', @user), status: :ok
  end

  def signup
    @user = User.new email: params[:email], password: params[:password]

    if @user.save
      response.headers['Authorization'] = "Bearer #{@user.jwt}"
      render json: serialize('User', @user), status: :created
    else
      render json: ame_serialize(@user.errors),
             status: :unprocessable_entity
    end
  end
end
