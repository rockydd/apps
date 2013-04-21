class CreateUserRelations < ActiveRecord::Migration
  def up
    create_table :user_relations do |t|
      t.integer :userid_from
      t.integer :userid_to
      t.timestamps
    end
  end

  def down
    drop_table :user_relations
  end
end
