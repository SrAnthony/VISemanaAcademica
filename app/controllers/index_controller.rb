class IndexController < ApplicationController
  def index
    @users_count = User.count
    @users_cat_1 = User.where(category: 1).count
    @users_cat_2 = User.where(category: 2).count
    @users_cat_3 = User.where(category: 3).count
  end

  def under_construction; end
end
