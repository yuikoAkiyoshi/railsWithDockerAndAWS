require 'rails_helper'

feature '記事', type: :feature do
    let(:user_a) { FactoryBot.create(:user) }
    let(:user_b) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article) }

    scenario '記事投稿・記事詳細画面のテスト' do
        # Aユーザーでログイン
        visit '/loginform'
        fill_in 'session[name]', with: user_a.name
        fill_in 'session[password]', with: user_a.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        # 記事投稿できる
        visit '/articles/new'
        fill_in 'article[title]', with: "記事のタイトル"
        fill_in 'article[body]', with: "記事の本文"
        click_button '保存'
        expect(page).to have_content '投稿を作成しました'
        # 自分の書いた記事には編集ボタンがある
        expect(page).to have_content '編集'
        # 自分の書いた記事には削除ボタンがある
        expect(page).to have_content '削除'
        # コメントフォームが存在する
        expect(page).to have_content 'コメントする'
        # 自分が書いた記事にはいいねボタンが存在しない
        expect(page).to have_no_selector('.like')

        # ログアウト
        find('a', text: 'LOGOUT').click
        expect(page).to have_content 'ログアウトしました'
        # Aユーザーの書いた記事ページへ
        find('.articles__card').click
        # 記事編集ボタンがない
        expect(page).to have_no_content '編集'
        # 記事削除ボタンがない
        expect(page).to have_no_content '削除'
        # コメントフォームが存在しない
        expect(page).to have_no_content 'コメントする'
        # いいねボタンが存在しない
        expect(page).to have_no_selector('.like')


        # Bユーザーでログイン
        visit '/loginform'
        fill_in 'session[name]', with: user_b.name
        fill_in 'session[password]', with: user_b.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        # Aユーザーの書いた記事ページへ
        find('.articles__card').click
        # 記事編集ボタンがない
        expect(page).to have_no_content '編集'
        # 記事削除ボタンがない
        expect(page).to have_no_content '削除'
        # コメントフォームが存在する
        expect(page).to have_content 'コメントする'
        # 他人が書いた記事にはいいねボタンが存在する
        expect(page).to have_selector('.like')

        # コメント投稿できる
        fill_in 'comment[comment]', with: "テストコメント"
        click_button '送信'
        expect(page).to have_content 'コメントを投稿しました'
        # 自分が投稿したコメントには削除ボタンが存在する
        expect(page).to have_selector('.comments__itemBtn')
    end
end