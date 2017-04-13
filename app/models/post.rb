class Post < ApplicationRecord
  has_many :post_topic
  has_many :topics, through: :post_topic

  validates :title, presence: true, length: { in: 3..255 }
  validates :body, presence: true, length: { in: 3..1400 }

  accepts_nested_attributes_for :topics, allow_destroy: true
end
