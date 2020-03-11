class UsersController < ApplicationController

  def new
    @user  = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to today_schedules_path
      flash[:notice] = "新規登録が完了しました"
    else
      # ここもエラーメッセージ引っ張ってきたうえで、どう間違ってるかをユーザーに伝えてあげると親切ですね
      flash[:alert] = "新規登録エラー：各項目を正しく入力して下さい"
      redirect_to root_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end