class ArticlesController < ApplicationController
    def index
        @articles = Article.all.order(created_at: :desc)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(title: params[:title], body: params[:body], image_name: [])
        if params[:image]
            @article.image_name = "#{@article.id}.jpg"
            image = params[:image]
            File.binwrite("public/article_images/#{@article.image_name}", image.read)
        end
        if @article.save
            flash[:notice] = "投稿を作成しました"
            redirect_to("/articles/index")
        else
            render("articles/new")
        end
    end

    def show
        @article = Article.find_by(id: params[:id])
    end

    def edit
        @article = Article.find_by(id: params[:id])
    end

    def update
        @article = Article.find_by(id: params[:id])
        @article.title = params[:title]
        @article.body = params[:body]
        if @article.save
            redirect_to("/articles/index")
        else
            render("articles/:id/edit")
        end
    end

    def destroy
        @article = Article.find_by(id: params[:id])
        @article.destroy
        redirect_to("/articles/index")
    end
end