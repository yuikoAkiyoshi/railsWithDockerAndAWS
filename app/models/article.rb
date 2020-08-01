class Article < ApplicationRecord
    has_many :comments, dependent: :delete_all
    has_many :article_tag_relations, dependent: :delete_all
    has_many :tags, through: :article_tag_relations

    validates :title, presence: true, length:{ maximum: 40 }
    validates :body, presence: true, length:{ maximum: 2000 }
end
