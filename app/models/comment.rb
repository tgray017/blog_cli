class Comment < ActiveRecord::Base
  belongs_to :commentor, :class_name => "User"
  belongs_to :post
  alias_attribute :user_id, :commentor_id
end
