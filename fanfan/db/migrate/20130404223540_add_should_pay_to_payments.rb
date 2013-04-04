class AddShouldPayToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :should_pay, :number
  end
end
