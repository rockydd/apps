class RemoveFinalFromPayments < ActiveRecord::Migration
  def up
    remove_column :payments, :final
  end

  def down
    add_column :payments, :final, :boolean
  end
end
