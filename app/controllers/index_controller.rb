class IndexController < ApplicationController
  before_action :authenticate_user!, only: :dash

  def index
    @users_count = User.count
    @users_cat_1 = User.where(category: 1).count
    @users_cat_2 = User.where(category: 2).count
    @users_cat_3 = User.where(category: 3).count
  end

  def dash
    redirect_to :user_account_path unless current_user.staff?
    @users = User.order(category: :desc).all
  end

  def under_construction; end
end
