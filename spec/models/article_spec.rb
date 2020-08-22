require 'rails_helper'

RSpec.describe Article, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do

    it 'ログイン済みかつtitleとbodyどちらも値が設定されていれば、OK' do
      user = @user
      article = user.articles.build(
        title: "タイトル",
        body: "ボディー",
      )
      expect(article).to be_valid
    end

    it 'titleが空だとNG' do
      user = @user
      article = user.articles.build(
        title: "",
        body: "ボディー",
      )
      article.valid?
      expect(article.errors[:title]).to include("を入力してください")
    end

    it 'bodyが空だとNG' do
      user = @user
      article = user.articles.build(
        title: "タイトル",
        body: "",
      )
      article.valid?
      expect(article.errors[:body]).to include("を入力してください")
    end

    it 'titleが40字でOK' do
      user = @user
      article = user.articles.build(
        title: 'a' * 40,
        body: "ボディー",
      )
      expect(article.valid?).to be true
    end

    it 'titleが41字でNG' do
      user = @user
      article = user.articles.build(
        title: 'a' * 41,
        body: "ボディー",
      )
      expect(article.valid?).to be false
    end

    it 'bodyが2000字でOK' do
      user = @user
      article = user.articles.build(
        title: "タイトル",
        body: 'a' * 2000,
      )
      expect(article.valid?).to be true
    end

    it 'bodyが2001字でNG' do
      user = @user
      article = user.articles.build(
        title: "タイトル",
        body: 'a' * 2001,
      )
      expect(article.valid?).to be false
    end
  end
end
