class UsersController < ApplicationController
  def show
    @user = current_user
    @articles = @user.articles.order(created_at: :desc)
  end
end
