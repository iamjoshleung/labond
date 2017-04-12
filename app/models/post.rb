class Post < ApplicationRecord
  has_many :post_topics
  has_many :topics, through: :post_topics

  validates :title, presence: true, length: { in: 3..255 }
  validates :body, presence: true, length: { in: 3..1400 }
end
