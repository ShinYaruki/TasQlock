class UsersController < ApplicationController

  def new
    @user  = User.new
  end

  def create
    @user = User.create(user_params)
    @user.password_confirmation = user_params[:password]
    if @user.save
      session[:user_id] = @user.id
      redirect_to today_tasks_path
      flash[:notice] = "新規登録が完了しました"
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to root_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end