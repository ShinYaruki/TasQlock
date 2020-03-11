class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_signed_in?

  private

  # このメソッドたたくとcurrent_userが返るわけではなく、@current_userにUserがセットされるって挙動になっているので、メソッド名をfind_current_userとかにしたほうが良い
  # もしくは、@current_userを使わずこのメソッドの使用先で都度都度ローカル変数にユーザーをセットするようにする
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user
    @current_user.present?  #ユーザがログインしているかどうかを判定
  end

  def login_required
    unless user_signed_in?
      redirect_to root_path 
    end
  end

end