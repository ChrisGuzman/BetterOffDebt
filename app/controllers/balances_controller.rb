class BalancesController < ApplicationController
  def index
    @balances = Balance.all
  end

  def show
    @balance = Balance.find(params[:id])
  end

  def new
    @balance = Balance.new
  end

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      redirect_to balances_path
    else
      render 'new'
    end
  end

  protected

  def balance_params
    params.require(:balance).permit(:amount, :id)
  end
end
