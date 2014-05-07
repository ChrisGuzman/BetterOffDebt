class AddNameToBalances < ActiveRecord::Migration
  def change
    add_column :balances, :name, :string
  end
end
