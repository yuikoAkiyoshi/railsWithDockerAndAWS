require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    # newアクションにgetのhttpメソッドでアクセスすることを擬似的に行っている
    # これによってgetのリクエストの結果がrequestという変数に格納される
    before { get :new }

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end
    # 指定したテンプレート(:new)が生成されているかチェック
    # rander_templateのマッチャーはrails_template_testingのgemをインストールしたことで利用可能になった
    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end
    # assignsメソッドの引数に変数名を指定したものを渡す
    # マッチャーにはbe_a_newを指定することでUserクラスに新しいオブジェクトがセットされているか確認
    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    before do
      # redirect to backの挙動として、referer(直前にどこのページを見ていたか)の情報を参照する
      # テストケースではrefererの値がないので明示的に設定する
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    context '正しいユーザー情報が渡って来た場合' do
      # 正しいユーザー情報をparamsという変数に設定
      let(:params) do
        { user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password',
          }
        }
      end

      # changeマッチャーはexpectの引数をブロッックで指定する必要がある
      it 'ユーザーが一人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      # postでcreateアクションを実行した結果をexpectに代入
      it '記事一覧ページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(articles_path)
      end
    end

    context 'パラメータに正しいユーザー名、確認パスワードが含まれていない場合' do
      before do
        post(:create, params: {
          user: {
            name: 'ユーザー1',
            password: 'password',
            password_confirmation: 'invalid_password'
          }
        })
      end

      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end

      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
      end
    end
  end
end