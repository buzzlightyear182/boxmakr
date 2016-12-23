class CompaniesController < ApplicationController

  before_action :find_company, except: [:index, :new, :create]

  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result(distinct: true)
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
        flash[:notice] = "#{@company.name} has been created"
        redirect_to companies_path
    else
        flash[:error] = @company.errors.full_messages.first
        render 'new'
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
        flash[:notice] = "#{@company.name} has been updated"
        redirect_to companies_path
    else
        flash[:error] = @company.errors.full_messages.first
        render 'new'
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = "Successfully deleted company"
    redirect_to companies_path
  end

  private
    def company_params
      params.require(:company).permit(:name, :address, :country, :email, :contact_person, :skype_id)
    end

    def find_company
      @company = Company.find(params[:id])
    end

end