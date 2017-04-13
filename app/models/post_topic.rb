class PostTopic < ApplicationRecord
  self.table_name = "posts_topics"
  belongs_to :post 
  belongs_to :topic 
end 