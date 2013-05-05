class CreateFantuans < ActiveRecord::Migration
  def change
    create_table :fantuans do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps
    end
  end
end
