class CreatePostsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :author_id
    end
  end
end
