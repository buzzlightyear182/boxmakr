class BoxesController < ApplicationController

  before_action :set_period, except: [:upload, :import]
  before_action :find_box, except: [:upload, :new, :import, :select_items]

  # def index
  #   @q = Box.ransack(params[:q])
  #   @boxes = @q.result.paginate(page: params[:page], per_page: 10)
  # end

  def upload
  end

  def import
    @box = nil
    @errors = Box.upload(params[:file])
    if @errors.empty?
      redirect_to periods_path, notice: 'New boxes uploaded.'
    else
      @errors.each do |error|
        flash[:error] = error
      end
      render 'upload'
    end
  end

  def show
  end

  def new
    @box = @period.boxes.new
  end

  def create
    @box = @period.boxes.new(box_params)
    if @box.save
      flash[:notice] = "#{@box.period.month_date} has been created"
      redirect_to period_path(@box.period.id)
    else
      flash[:error] = @box.errors.full_messages.first
      render 'new'
    end
  end

  def edit
  end

  def update
    if @box.update(box_params)
      flash[:notice] = "#{@box.period.month_date} has been updated"
      redirect_to period_path(id: @period.id)
    else
      flash[:error] = @box.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @box.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to period_path(@period.id)
  end

  def select_items
    flash[:notice] = nil
    flash[:error] = nil
    @q = Item.ransack(params[:q])
    @items = @q.result.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_item
    item = Item.find_by_id(params[:item_id])
    @box.items << item
    flash[:notice] = "#{item.description} has been added to #{@box.name}"
    respond_to do |format|
      format.js
    end
  end

  def remove_item
    item = Item.find_by_id(params[:item_id])
    @box.items.delete(item)
    flash[:notice] = "#{item.description} has been removed from #{@box.name}"
    respond_to do |format|
      format.js
    end
  end

  private
    def box_params
      params.require(:box).permit(:forecast, :actual, :box_type_id, :month_date)
    end

    def find_box
      @box = @period.boxes.find(params[:id])
    end

    def set_period
      @period = Period.find(params[:period_id])
    end

    def item_params
      params.require(:item).permit(:item_id)
    end

end