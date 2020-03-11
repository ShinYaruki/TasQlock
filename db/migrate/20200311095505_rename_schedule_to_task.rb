class RenameScheduleToTask < ActiveRecord::Migration[5.2]
  def change
    rename_table :schedules, :tasks
  end
end
