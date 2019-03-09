class AddTimestampsToPostsTable < ActiveRecord::Migration[4.2]
  def change
    add_timestamps :posts
  end
end
