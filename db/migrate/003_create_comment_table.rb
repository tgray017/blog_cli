class CreateCommentTable < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :post_id
      t.integer :commentor_id
    end
  end
end
