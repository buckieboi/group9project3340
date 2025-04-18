class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Set an initial balance if you like; default comes from migration as 0.
    @user.balance ||= 100  # For testing, you might want a starting balance.
    if @user.save
      flash[:notice] = "Account created successfully"
      redirect_to dashboard_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def budget_reset
    if current_user
      current_user.reset_budget!
      render json: { message: "Budget reset successful", archived: current_user.transactions.where(archived: true) }
    else
      render json: { error: "User not signed in" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
