require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'バリデーション' do

    it 'ログイン済みかつcommentに値が設定されていればOK' do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it 'commentが空だとNG' do
      comment = FactoryBot.build(:comment) do |c|
        c.comment = ""
      end
      expect(comment.valid?).to be false
    end

    it 'commentが500字でOK' do
      comment = FactoryBot.build(:comment) do |c|
        c.comment = "a" * 500
      end
      expect(comment.valid?).to be true
    end

    it 'commentが501字でNG' do
      comment = FactoryBot.build(:comment) do |c|
        c.comment = "a" * 501
      end
      expect(comment.valid?).to be false
    end
  end
end
