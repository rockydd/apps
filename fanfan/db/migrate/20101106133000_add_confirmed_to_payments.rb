class AddConfirmedToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :confirmed, :boolean
  end

  def self.down
    remove_column :payments, :confirmed
  end
end
