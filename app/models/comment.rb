class Comment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true, length: { in: 3..1400 }
end
