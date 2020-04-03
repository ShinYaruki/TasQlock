class Task < ApplicationRecord
  belongs_to :tag
  belongs_to :user

  validates :date, presence: true
  validates :starttime, presence: { message: 'を00:00〜24:00の値で入力して下さい' }
  validates :finishtime, presence: { message: 'を00:00〜24:00の値で入力して下さい' }
  validates :title, presence: true
  validates :user_id, presence: true

  # def self.current_user
  #   User.find_by(id: session[:user_id]) if session[:user_id]
  # end

  # def self.newtask
  #   {
  #     schedule_list: Task.where(date: Time.zone.now.beginning_of_day).where(user_id: @current_user.id).order(starttime: "asc"),
  #     today: Time.zone.now.strftime("%Y%m%d")
  #   }
  # end
end
