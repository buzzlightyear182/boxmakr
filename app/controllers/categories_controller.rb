class CategoriesController < ApplicationController

  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
        flash[:notice] = "Category has been created"
        redirect_to categories_path
    else
        flash[:error] = "Error"
        render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
        flash[:notice] = "Category has been created"
        redirect_to categories_path
    else
        flash[:error] = "Error"
        render 'new'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :tariff_rate)
    end

    def find_category
      @category = Category.find(params[:id])
    end

end