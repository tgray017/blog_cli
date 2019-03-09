class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  alias_attribute :user_id, :author_id
  has_many :comments
end
