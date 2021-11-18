class AuthController < ApplicationController
  def login
    user = User.login(auth_params[:login]).first
    # user&. is a shorthand for:
    # user && user.authenticate(auth_params[:password])
    if user&.authenticate(auth_params[:password])
      token = JwtService.encode(user)
      render json: { jwt: token, username: user.username }
    else
      render json: { error: 'Incorrect email or password' }, status: 422
    end
  end

  def register
    user = User.create(auth_params)
    if user.errors.any?
      render json: { errors: user.errors.full_messages }, status: 422
    else
      token = JwtService.encode(user)
      render json: { jwt: token, username: user.username }, status: 201
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:auth, :login, :email, :password, :password_confirmation, :username)
  end
end
