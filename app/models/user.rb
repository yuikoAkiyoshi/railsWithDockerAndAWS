class User < ApplicationRecord
    has_many :articles, dependent: :delete_all
    has_many :comments, dependent: :delete_all

    # password属性とpassword_confirmation属性がUserモデルに追加（二回パスワード記入して正しいパスワードかチェック）
    has_secure_password

    validates :name,
        presence: true,
        uniqueness: true,
        length: { maximum: 16 },
        format: {
            with: /\A[a-z0-9]+\z/,
            message: 'は小文字英数字で入力してください'
        }
    validates :password,
        length: { minimum: 8 }
    
    mount_uploader :image, ImageUploader
end
