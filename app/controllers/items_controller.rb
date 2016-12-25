class ItemsController < ApplicationController

  before_action :find_item, only: [:edit, :show, :destroy, :update]

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def download
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
    respond_to do |format|
      format.html
      format.csv { send_data @items.to_csv }
    end
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

  def upload
  end

  def import
    @item = nil
    @errors = Item.upload(params[:file])
    if @errors.empty?
      redirect_to items_path, notice: 'New items uploaded.'
    else
      @errors.each do |error|
        flash[:error] = error
      end
      render 'upload'
    end
  end

  private
    def item_params
      params.require(:item).permit(:description, :category_id, :top_SKU, :shelf_life, :case_weight, :case_size, :brand_id, :case_price, :case_price_currency, :case_pallet, :unit_size, :case_dimension_length, :case_dimension_width, :case_dimension_height)
    end

    def find_item
      @item = Item.find(params[:id])
    end

end