class BoxesController < ApplicationController

  before_action :set_period, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :find_box, only: [:show, :edit, :update, :destroy]

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
      redirect_to boxes_path, notice: 'New boxes uploaded.'
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

end