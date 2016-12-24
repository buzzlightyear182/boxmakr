class ItemsController < ApplicationController

  before_action :find_item, except: [:index, :new, :create]

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.description} has been created"
      redirect_to items_path
    else
      flash[:error] = @item.errors.full_messages.first
      render 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "#{@item.description} has been updated"
      redirect_to items_path
    else
      flash[:error] = @item.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(:description, :category_id, :top_SKU, :shelf_life, :case_weight, :case_size, :brand_id, :case_price, :case_price_currency, :case_pallet, :unit_size, :case_dimension_length, :case_dimension_width, :case_dimension_height)
    end

    def find_item
      @item = Item.find(params[:id])
    end

end