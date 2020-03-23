class TasksController < ApplicationController
  before_action :login_required

  def new
    @task = Task.new
    @schedule_list = Task.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
    @today = Time.zone.now.strftime("%Y%m%d")
  end

  def create
    @task = Task.new(schedule_params)
      if @task.save
        flash[:notice] = "スケジュールを登録しました"
        redirect_to new_task_path
        # respond_to do |format| 非同期通信でcreateを発火予定だったが保留
        #   format.html {redirect_to new_task_path}
        #   format.json
        # end 
      else
        flash[:alert] = @task.errors.full_messages
        redirect_to new_task_path
      end
  end

  def edit
    @task = Task.find(params[:id])
    @starttime = @task.starttime.strftime("%H:%M")
    @finishtime = @task.finishtime.strftime("%H:%M")
    @schedule_list = Task.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(schedule_params)
        redirect_to today_tasks_path
        flash[:notice] = "スケジュールを編集しました"
      else
        flash[:alert] = @task.errors.full_messages
        redirect_to edit_task_path
      end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to today_tasks_path
  end

  def today
    date = Time.now.to_s.slice(0..9)
    @month = date.slice(5..6)
    @day = date.slice(8..9)
    @tasks = Task.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
    @memo = Memo.new
    @memos = Memo.where(date: Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(created_at: "asc")
  end

  def calendar
    @tmp = params[:text]
    @month = @tmp[5..6]
    @day = @tmp[8..9]
    @cale = Task.where(date: @tmp).where(user_id: current_user.id).order(starttime: "asc")
    @memos = Memo.where(date: @tmp).where(user_id: current_user.id).order(created_at: "asc")
  end

  def done
    @task = Task.find(params[:id])
    @task.update(done: true)
    redirect_to today_tasks_path
    # respond_to do |format| 非同期通信でdoneを発火予定だったが保留
    #   format.html {redirect_to today_tasks_path}
    #   format.json
    # end 
    flash[:notice] = "スケジュールが完了しました"
  end

  def calendardone
    @task = Task.find(params[:id])
    @task.update(done: true)
    redirect_to today_tasks_path
    flash[:notice] = "#{@task.date}のスケジュールが完了しました"
  end

  private
    def schedule_params
      params.require(:task).permit(:date, :starttime, :finishtime, :done, :tag_id, :title, :description).merge(user_id: current_user.id)
    end

end
