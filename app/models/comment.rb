class Comment < ApplicationRecord
  belongs_to :article

  validates :name, presence: true, length:{ maximum: 10 }
  validates :comment, presence: true, length:{ maximum: 1000 }
end
