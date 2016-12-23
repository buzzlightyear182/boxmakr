class ExchangeRatesController < ApplicationController

  before_action :find_exchange_rate, except: [:index, :new, :create]

  def index
    @exchange_rates = ExchangeRate.all
  end

  def new
    @exchange_rate = ExchangeRate.new
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)
    @exchange_rate.date = Date.strptime(exchange_rate_params["date"], '%d %b %Y')
    if @exchange_rate.save
        flash[:notice] = "#{@exchange_rate.base_currency} has been created"
        redirect_to exchange_rates_path
    else
        flash[:error] = @exchange_rate.errors.full_messages.first
        render 'new'
    end
  end

  def edit
  end

  def update
    @exchange_rate.date = Date.strptime(exchange_rate_params["date"], '%d %b %Y')
    if @exchange_rate.update(exchange_rate_params)
        flash[:notice] = "#{@exchange_rate.base_currency} has been updated"
        redirect_to exchange_rates_path
    else
        flash[:error] = @exchange_rate.errors.full_messages.first
        render 'new'
    end
  end

  def destroy
    @exchange_rate.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to exchange_rates_path
  end

  private
    def exchange_rate_params
      params.require(:exchange_rate).permit(:base_currency, :amount, :date, :active)
    end

    def find_exchange_rate
      @exchange_rate = ExchangeRate.find(params[:id])
      if @exchange_rate.active?
        @exchange_rate
      else
        @exchange_rate.errors[:base] = "Exchange rate is not active anymore"
        flash[:error] = @exchange_rate.errors.full_messages.first
        redirect_to exchange_rates_path
      end
    end

end