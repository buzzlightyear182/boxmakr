class BoxesController < ApplicationController

  before_action :find_box, only: [:show, :edit, :update, :destroy]

  def index
    @q = Box.ransack(params[:q])
    @boxes = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def upload
  end

  def show
  end

  def import
    @box = nil
    @errors = Box.upload(params[:file])
    if @errors.empty?
      redirect_to boxes_path, notice: 'New boxes uploaded.'
    else
      @errors.each do |error|
        flash[:error] = error
      end
      render 'upload'
    end
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params)
    if @box.save
      flash[:notice] = "#{@box.month_date} has been created"
      redirect_to boxes_path
    else
      flash[:error] = @box.errors.full_messages.first
      render 'new'
    end
  end

  def edit
  end

  def update
    if @box.update(box_params)
      flash[:notice] = "#{@box.month_date} has been updated"
      redirect_to boxes_path
    else
      flash[:error] = @box.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @box.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to boxes_path
  end

  private
    def box_params
      params.require(:box).permit(:forecast, :actual, :box_type_id, :month_date)
    end

    def find_box
      @box = Box.find(params[:id])
    end

end