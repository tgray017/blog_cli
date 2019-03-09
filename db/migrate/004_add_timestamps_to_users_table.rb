class AddTimestampsToUsersTable < ActiveRecord::Migration[4.2]
  def change
    add_timestamps :users
  end
end
