class BalancesController < ApplicationController
  def index
    @balances = Balance.all
  end

  def show
    @balance = Balance.find(params[:id])
  end

  def edit
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

  def update
    @balance = Balance.find(params[:id])
    if @balance.update(balance_params)
      redirect_to balances_path
    else
      redirect_to edit_balance_path(@balance.id)
    end
  end

  protected

  def balance_params
    params.require(:balance).permit(:amount, :id, :name)
  end
end
