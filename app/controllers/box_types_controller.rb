class BoxTypesController < ApplicationController

  before_action :find_box_type, except: [:index, :new, :create]

  def index
    @box_types = BoxType.all
  end

  def new
    @box_type = BoxType.new
  end

  def create
    @box_type = BoxType.new(box_type_params)
    if @box_type.save
      flash[:notice] = "#{@box_type.name} has been created"
      redirect_to box_types_path
    else
      flash[:error] = @box_type.errors.full_messages.first
      render 'new'
    end
  end

  def edit
  end

  def update
    if @box_type.update(box_type_params)
      flash[:notice] = "#{@box_type.name} has been updated"
      redirect_to box_types_path
    else
      flash[:error] = @box_type.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @box_type.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to box_types_path
  end

  private
    def box_type_params
      params.require(:box_type).permit(:name, :price, :target_cost, :threshold, :max_item_count)
    end

    def find_box_type
      @box_type = BoxType.find(params[:id])
    end

end