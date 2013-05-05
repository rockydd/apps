class CreateFantuansUsers < ActiveRecord::Migration
  def up
    create_table :fantuans_users do |t|
      t.references :user
      t.references :fantuan
    end
  end

  def down
    drop_table :fantuans_users
  end
end
