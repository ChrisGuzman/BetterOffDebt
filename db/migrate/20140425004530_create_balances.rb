class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
