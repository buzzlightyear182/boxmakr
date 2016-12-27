class PeriodsController < ApplicationController

  before_action :find_period, only: [:show, :edit, :update, :destroy]

  def index
    @q = Period.ransack(params[:q])
    @periods = @q.result
  end

  def upload
  end

  def show
  end

  def new
    @period = Period.new
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      flash[:notice] = "#{@period.month_date} has been created"
      redirect_to boxes_path
    else
      flash[:error] = @period.errors.full_messages.first
      render 'new'
    end
  end

  def edit
  end

  def update
    if @period.update(period_params)
      flash[:notice] = "#{@period.month_date} has been updated"
      redirect_to boxes_path
    else
      flash[:error] = @period.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @period.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to boxes_path
  end

  private
    def period_params
      params.require(:box).permit(:name, :month_date)
    end

    def find_period
      @period = Period.find(params[:id])
    end

end