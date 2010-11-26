class Balance < ActiveRecord::Migration
  def self.up
    create_table :balances do |t|
      t.integer :user_id
      t.decimal :amount 
    end
  end

  def self.down
    drop_table :balances
  end
end
