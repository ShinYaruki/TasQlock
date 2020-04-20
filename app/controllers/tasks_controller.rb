class TasksController < ApplicationController
  before_action :login_required
  before_action :schedule_list_get, only: [:new, :edit]
  before_action :set_task, only:[:edit, :update, :destroy, :done, :calendardone]
  before_action :set_today, only:[:new, :today]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(schedule_params)
      if @task.save
        flash[:notice] = "スケジュールを登録しました"
        redirect_to new_task_path
      else
        flash[:alert] = @task.errors.full_messages
        redirect_to new_task_path
      end
  end

  def edit
    @starttime = @task.starttime.strftime("%H:%M")
    @finishtime = @task.finishtime.strftime("%H:%M")
  end

  def update
    if @task.update(schedule_params)
      redirect_to today_tasks_path
      flash[:notice] = "スケジュールを編集しました"
    else
      flash[:alert] = @task.errors.full_messages
      redirect_to edit_task_path
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to today_tasks_path
  end

  def today
    @month = @date.month
    @day = @date.day
    @tasks = Task.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
    @memo = Memo.new
    @memos = Memo.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(created_at: "asc")
  end

  def calendar
    @tmp = params[:text].to_date #日付情報を受取る為、_calendar_bar.html.hamlに架空inputを設置しており、application.js経由でparams[:text]を取得している
    @month = @tmp.month
    @day = @tmp.day
    @calendar = Task.where(date: @tmp).where(user_id: current_user.id).order(starttime: "asc")
    @memos = Memo.where(date: @tmp).where(user_id: current_user.id).order(created_at: "asc")
  end

  def done
    @task.update(done: true)
    redirect_to today_tasks_path
    flash[:notice] = "スケジュールが完了しました"
  end

  def calendardone
    @task.update(done: true)
    redirect_to today_tasks_path
    flash[:notice] = "#{@task.date}のスケジュールが完了しました"
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_today
      @date = Time.zone.now.strftime("%Y-%m-%d").to_date
    end

    def schedule_list_get
      @schedule_list = Task.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
    end

    def schedule_params
      params.require(:task).permit(:date, :starttime, :finishtime, :done, :tag_id, :title, :description).merge(user_id: current_user.id)
    end

end
