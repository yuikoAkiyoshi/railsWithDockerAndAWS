class UsersController < ApplicationController
  before_action :set_target_user, only: %i[edit update destroy articles]

  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to articles_path
    else
      redirect_to :back, flash: {
        user: user,
        error_messages: user.errors.full_messages
      }
    end
  end

  def login
  end

  def edit
    if !(@current_user)
      redirect_to articles_path, flash: { notice: "ログインしてください" }
    else
      @user = User.find(params[:id])
    end
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to articles_path
    else
      redirect_to :back, flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end
  end
  
  def destroy
    @user.destroy
    @user.remove_image!
    @user.save
    redirect_to articles_path
  end

  def index
    @users = User.all
  end

  def articles
    @articles = Article.where(user_id: params[:id])
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def likes
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :image)
  end

  def set_target_user
    @user = User.find(params[:id])
  end
end
