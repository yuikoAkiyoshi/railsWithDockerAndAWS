class Tag < ApplicationRecord
    has_many :article_tag_relations, dependent: :delete_all
    has_many :articles, through: :article_tag_relations
end
