class User < ApplicationRecord
    has_many :articles, dependent: :delete_all
    has_many :comments, dependent: :delete_all

    # following_relationshipsモデルを架空で作成しています。
    # class_name: "Relationship"でRelationshipモデルの、foreign_key: "follower_id" で、follower_idを参考に、
    # following_relationshipsモデルへアクセスするようにしています。
    has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy

    # through: :following_relationshipsで、中間テーブルにfollowing_relationshipsテーブルを指定しています。
    # その結果、user.following と打つだけで、userが中間テーブルfollowing_relationships を取得し、
    # その1つ1つのfollowing_idから、「フォローしているUser達」を取得できるようになります。
    has_many :following, through: :following_relationships

    # follower_relationshipsモデルを架空で作成しています。
    # class_name: "Relationship"でRelationshipモデルの、foreign_key: "following_id" で、folloing_idを参考に、
    # following_relationshipsモデルへアクセスするようにしています。
    has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy

     # through: :follower_relationshipsで、中間テーブルにfollower_relationshipsテーブルを指定しています。
    # その結果、user.followers と打つだけで、userが中間テーブルfollower_relationships を取得し、
    # その1つ1つのfollower_idから、「フォローされているUser達」を取得できるようになります。
    has_many :followers, through: :follower_relationships

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

    #following_relationshipsテーブルのfollowing_idにuserのidが存在するか確認
    def following?(user)
        following_relationships.find_by(following_id: user.id)
    end

    #フォローするときのメソッド.following_idにuser.idを代入
    def follow(user)
        following_relationships.create!(following_id: user.id)
    end

    #フォローを外すときのメソッド.following_idのuser.idを削除
    def unfollow(user)
        following_relationships.find_by(following_id: user.id).destroy
    end
end
