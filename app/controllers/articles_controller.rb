class ArticlesController < ApplicationController
    before_action :set_target_article, only: %i[show edit update destroy]

    def index
        @articles = params[:tag_id].present? ? Tag.find(params[:tag_id]).articles : Article.all
        @articles = @articles.all.order(created_at: :desc)
    end

    def new
        @article = Article.new
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
        @comment = Comment.new(article_id: @article.id)
    end

    def edit
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
        redirect_to articles_path, flash: { notice: "「#{@article.title}」を削除しました"}
    end

    private

    def article_params
        params.require(:article).permit(:title, :body, image_name: [], tag_ids: [] )
    end

    def set_target_article
        @article = Article.find(params[:id])
    end
end