class MemosController < ApplicationController
  def index
    @memos = Memo.find_by("created_at >= ?", Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(created_at: "asc")
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.date = Time.now.to_s.slice(0..9)
    @memo.save
    respond_to do |format|
      format.html {redirect_to today_schedules_path}
      format.json
    end 
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    respond_to do |format|
      format.html {redirect_to today_schedules_path}
      format.json
    end
  end

  private
  def memo_params
    params.require(:memo).permit(:memo, :date).merge(user_id: current_user.id)
  end
end