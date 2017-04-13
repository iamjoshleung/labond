class Topic < ApplicationRecord
  has_many :post_topic
  has_many :posts, through: :post_topic

  validates :name, presence: true, length: { in: 3..26 }, uniqueness: true
end
