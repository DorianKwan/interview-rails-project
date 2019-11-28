class CategoriesController < ApplicationController

  def show
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts.order('created_at desc').limit(100)
  end

end
