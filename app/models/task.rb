class Task < ApplicationRecord
  belongs_to :tag
  belongs_to :user

  validates :date, presence: true
  validates :starttime, presence: { message: 'を00:00〜24:00の値で入力して下さい' }
  validates :finishtime, presence: { message: 'を00:00〜24:00の値で入力して下さい' }
  validates :title, presence: true
  validates :user_id, presence: true
end
