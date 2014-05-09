class LoginsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.try(:authenticate, params[:password])
      set_current_user(user)
      redirect_to root_path, notice: "Any new debts, #{user.name}?"
    else
      flash.now[:danger] = 'Login failed.'
      redirect_to login_path
    end
  end

  def destroy
    set_current_user(nil)
    redirect_to root_path, info: "You have been logged out."
  end
end
