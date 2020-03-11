class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date    :date
      t.time    :starttime
      t.time    :finishtime
      t.string  :title
      t.string  :description
      t.boolean :done, default: false
      t.bigint  :tag_id, foreign_key: true
      t.bigint  :user_id, foreign_key: true
      t.timestamps
    end
  end
end
