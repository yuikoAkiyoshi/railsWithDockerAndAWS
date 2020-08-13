class Article < ApplicationRecord
    belongs_to :user

    has_many :comments, dependent: :delete_all
    has_many :article_tag_relations, dependent: :delete_all
    has_many :tags, through: :article_tag_relations
    has_many :likes
    has_many :users, through: :likes

    validates :title, presence: true, length:{ maximum: 40 }
    validates :body, presence: true, length:{ maximum: 2000 }

    mount_uploader :image, ImageUploader

    def liked_by?(user)
        likes.where(user_id: user.id).exists?
    end
end
