require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'indexテンプレートをレンダリングすること' do
      expect(response).to render_template :index
    end
    
    it '新しいarticlesオブジェクトがビューに渡されること' do
      expect(assigns(:article)).to be_a_new Articles
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいarticlesオブジェクトがビューに渡されること' do
      expect(assigns(:article)).to be_a_new Articles
    end
  end

  describe 'POST #create' do
    before do
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    context '正しいタイトル、ボディーが入って来た場合' do
      let(:params) do
        { article: {
            title: 'title',
            body: 'body'
          }
        }
      end

      it '記事が一つ増えていること' do
        expect { post :create, params: params }.to change(Article, :count).by(1)
      end

      it '記事詳細ページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(article)
      end
    end

    context 'パラメータに正しいタイトル、ボディーが含まれていない場合' do
      before do
        post(:create, params: {
          article: {
            title: '',
            body: ''
          }
        })
      end

      it '新規作成画面にリダイレクトされること' do
        expect(response).to redirect_to(new_article_path)
      end

      it 'タイトルのエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'タイトルを入力してください'
      end

      it '本文のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include '本文を入力してください'
      end
    end
  end
end