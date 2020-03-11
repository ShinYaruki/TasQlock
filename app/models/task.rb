class Task < ApplicationRecord
  belongs_to :tag
  belongs_to :user

  validates :date, presence: true
  validates :starttime, presence: true
  validates :finishtime, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
end
