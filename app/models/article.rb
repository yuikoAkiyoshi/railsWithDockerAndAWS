class Article < ApplicationRecord
    validates :title, presence: true, length:{ maximum: 40 }
    validates :body, presence: true, length:{ maximum: 2000 }
end
