class SchedulesController < ApplicationController
  before_action :login_required

  def index
  end

  def new
    @schedule = Schedule.new
    @newsche = Schedule.where("date >= ?", Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
    @today = Time.zone.now.strftime("%Y%m%d")
  end

  def create
    @schedule = Schedule.new(schedule_params)
      # スケジュールがvalidでないのはいろいろな要因があるが、常に「必須項目を入力してください」のエラーが出るのでわかりにくい
      # 例えば時刻に"25:00"とか入れても「必須項目を入力してください」って言われる。valid?がfalseだったら@schedule.errors.messageにエラーメッセージが詰め込まれるので、それを表示する
      if @schedule.valid?
        # save!じゃなくてsaveなら、そこでバリデーションかけてダメならfalse返るので、valid?がsaveどっちかでいい
        @schedule.save
        flash[:notice] = "スケジュールを登録しました"
        respond_to do |format|
          format.html {redirect_to new_schedule_path}
          format.json
        end 
      else
        flash[:alert] = "必須項目を入力して下さい"
        redirect_to new_schedule_path
      end
  end

  # show使ってないなら消そう
  def show
  end

  def edit
    # paramsから該当モデルのインスタンスを引っ張ってくるのは定番なので、privateメソッド切ってbefore_actionで呼ぶように俺はよくやってた。
    # before_action :find_schedule, except: [:new, :create]的な
    @schedule = Schedule.find(params[:id])

    # ScheduelModelがフォーマットされた時間を返すって形にしたほうが、ModelとControllerの責務を分離できた状態になる
    # 例えば、Scheduleにformatted_starttimeみたいなメソッドを生やしてControllerはそれを呼ぶだけ
    # もしくは、今回の場合であればこれは完全にview用の処理なので、helperに書くほうが適してるかも。
    @starttime = @schedule.starttime.strftime("%H:%M")
    @finishtime = @schedule.finishtime.strftime("%H:%M")

    # newsche -> 新しいスケジュールってより「スケジュール一覧 -> schedule_list」みたいな名前のほうが何に使われてるかわかりやすそう
    # こういうのはModelのscopeで定義してわかりやすい名前をつけて、Controllerはそれを呼ぶだけでよい状態にしましょう。scopeわからなかったら「rails model scope」とかでググってみて
    # 上にも責務を分離とか書いたけど、イメージとしてはControllerはModelの詳しい構造とか知らなくても「こいつの今日のスケジュールほしいわ！」って問い合わせたらもらえるみたいな感じ
    # Schedule.today_by_user(current_user.id)とかで呼べるとシンプルだしコード読むだけでもなにしてるかわかりやすいよね
    @newsche = Schedule.where("date >= ?", Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")
  end

  def update
    schedule = Schedule.find(params[:id])
    　# createで書いたコメントと同じ
      if schedule.valid?
        schedule.update(schedule_params)
        redirect_to today_schedules_path
        flash[:notice] = "スケジュールを編集しました"
      else
        redirect_to edit_schedule_path
        flash[:alert] = "必須項目を入力して下さい"
      end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to today_schedules_path
  end

  def today
    # Time.nowよりTime.zone.nowを決めで使っておくほうがあんまりUTCとJST意識しなくて済みます。詳しくはググって
    # アプリケーション的にはStringにしてしまうのではなく、Time型のまま持っといたほうがだいたい楽です。すぐ下で書いたdate.monthとかはTime型のメソッドでありStringのメソッドではなかったりするので。
    date = Time.now.to_s.slice(0..9)
    # Rubyは「こういうメソッドでこれ取れたらな」ってのがあるので、こういうのはdate.monthとかdate.dayとかで持ってこれます
    @month = date.slice(5..6)
    @day = date.slice(8..9)
    # dateのwhereが「いつから」はあるけど「いつまで」がないので、未来のタスクも出てくる
    @schedules = Schedule.where("date >= ?", Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(starttime: "asc")

    # Memo、現時点は使われてない？（導線とかいろいろパット見でみつからなかった）
    @memo = Memo.new
    @memos = Memo.where("date >= ?", Time.zone.now.beginning_of_day).where(user_id: current_user.id).order(created_at: "asc")
  end

  def calendar
    # textパラメータに何入ってきて、こいつは何してるのかがいまいち読みとれてなかった　すまぬ
    # なので何してるかちゃんとわかんないんだけど、なんとなくここでやるべき処理ではない気がする
    @tmp = params[:text]
    @month = @tmp[5..6]
    @day = @tmp[8..9]
    @cale = Schedule.where(date: @tmp).where(user_id: current_user.id).order(starttime: "asc")
    @memos = Memo.where(date: @tmp).where(user_id: current_user.id).order(created_at: "asc")
  end

  def done
    @schedule = Schedule.find(params[:id])
    @schedule.update(done: 1)
    respond_to do |format|
      format.html {redirect_to today_schedules_path}
      format.json
    end 
    flash[:notice] = "スケジュールが完了しました"
  end

  private
    def schedule_params
      params.require(:schedule).permit(:date, :starttime, :finishtime, :done, :tag_id, :title, :description).merge(user_id: current_user.id)
    end

end
