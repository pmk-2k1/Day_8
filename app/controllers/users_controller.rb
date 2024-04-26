class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: {
      user: current_user.as_json(except: :jti)
    }, status: :ok
  end

  def edit

  end

  def update
    if @user.update(user_params)
      render json: {
        user: current_user.as_json(except: :jti)
      }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fullname, :email, :password, :admin, :reset_password_token,
                                 :current_password, :password_confirmation)
  end
end
