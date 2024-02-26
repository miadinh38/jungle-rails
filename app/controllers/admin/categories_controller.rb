class Admin::CategoriesController < ApplicationController
  before_action :http_basic_auth
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      redirect_to admin_categories_url, notice: "Category created!"
    else
      render :new
    end
  end

  private
  def http_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end

  def category_params
    params.require(:category).permit(
      :name,
      :description
    )
  end
end
