class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to balances_path, success: "Thanks for creating an account!"
    else
      render "new", danger: "There was an issue creating your account."
    end
  end

  protected
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
