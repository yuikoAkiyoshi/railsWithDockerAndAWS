class User < ApplicationRecord
    has_many :articles, dependent: :delete_all
    has_many :comments, dependent: :delete_all
    has_many :relationships
    # relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセス。user.followingsでフォローしているUserを取得できる
    has_many :followings, through: :relationships, source: :follow
    # relaitonshipsテーブルにアクセスする時、follow_idを入口とする
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverse_of_relationships, source: :user

    # password属性とpassword_confirmation属性がUserモデルに追加（二回パスワード記入して正しいパスワードかチェック）
    has_secure_password

    validates :name,
        presence: true,
        uniqueness: true,
        length: { maximum: 10 },
        format: {
            with: /\A[a-z0-9]+\z/,
            message: 'は小文字英数字で入力してください'
        }
    validates :password,
        length: { minimum: 8 }
    
    mount_uploader :image, ImageUploader

    def follow(other_user)
        unless self == other_user
          self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end

    def following?(other_user)
        self.followings.include?(other_user)
    end
end
