class HomesController < ApplicationController

  def index
    if user_signed_in?
      redirect_to today_tasks_path
    else
      @user = User.new
    end
  end

end
