class RenameNameAsDebtorToBalances < ActiveRecord::Migration
  def change
    change_table :balances do |t|
      t.rename :name, :debtor
    end
  end
end
