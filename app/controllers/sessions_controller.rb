class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to articles_path
    else
      redirect_to :back, flash: { notice: "ユーザー名かパスワードが違います"}
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
