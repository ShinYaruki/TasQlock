class SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to today_tasks_path # 当日スケジュール一覧画面にリダイレクト
      flash[:notice] = "ログインしました"
    else
      redirect_to root_path
      flash[:alert] = "入力内容が正しくありません"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
    flash[:notice] = "ログアウトしました"
  end
      
  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

end