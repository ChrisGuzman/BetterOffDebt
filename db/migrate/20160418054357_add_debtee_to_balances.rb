class AddDebteeToBalances < ActiveRecord::Migration
  def change
    add_column :balances, :debtee, :string
  end
end
