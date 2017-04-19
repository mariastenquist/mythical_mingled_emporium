class CategoriesController < ApplicationController
  def show
    @category = Category.includes(:creatures).find_by(name: params[:category].titleize)
  end

  def index
    @categories = Category.all
  end
end
