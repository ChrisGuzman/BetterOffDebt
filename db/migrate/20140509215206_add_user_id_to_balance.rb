class AddUserIdToBalance < ActiveRecord::Migration
  def change
    add_column :balances, :user_id, :integer
  end
end
