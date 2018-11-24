class CategoriesController < ApplicationController
  before_action :category, only: %i[show update destroy]

  def index
    @categories = Category.all
  end

  def show
    @category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category    
  end

  def update
    @category 
    if @category.update_attributes(category_params)
      flash[:notice] = "#{@category.name} updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category deleted"
    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category = Category.find(params[:id])
  end

end