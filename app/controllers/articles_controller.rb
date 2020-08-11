class ArticlesController < ApplicationController
    before_action :set_target_article, only: %i[show edit update destroy]

    def index
        @articles = params[:tag_id].present? ? Tag.find(params[:tag_id]).articles : Article.all
        @articles = @articles.page(params[:page])
    end

    def new
        if @current_user
            @article = Article.new
        else
            redirect_to articles_path, flash: { notice: "ログインしてください" }
        end
    end

    def create
        article = Article.new(article_params)
        if article.save
            flash[:notice] = "投稿を作成しました"
            redirect_to article
        else
            redirect_to new_article_path, flash: {
                article: article,
                error_messages: article.errors.full_messages
            }
        end
    end

    def show
        @user = User.find_by(id: @article.user_id)
        @comment = Comment.new(article_id: @article.id)
    end

    def edit
        if !(@current_user)
            redirect_to articles_path, flash: { notice: "ログインしてください" }
        end
    end

    def update
        if @article.update(article_params)
            redirect_to @article
        else
            redirect_to :back, flash: {
                article: @article,
                error_messages: @article.errors.full_messages
            }
        end
    end

    def destroy
        @article.destroy
        @article.remove_image!
        @article.save
        redirect_to articles_path, flash: { notice: "「#{@article.title}」を削除しました"}
    end

    private

    def article_params
        params.require(:article).permit(:title, :body, :image, :user_id, tag_ids: [])
    end

    def set_target_article
        @article = Article.find(params[:id])
    end
end