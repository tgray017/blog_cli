class AddTimestampsToCommentsTable < ActiveRecord::Migration[4.2]
  def change
    add_timestamps :comments
  end
end
