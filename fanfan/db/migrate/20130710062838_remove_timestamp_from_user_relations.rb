class RemoveTimestampFromUserRelations < ActiveRecord::Migration
  def up
    remove_column :user_relations, :created_at
    remove_column :user_relations, :updated_at
  end

  def down
    add_column :user_relations, :updated_at, :datetime
    add_column :user_relations, :created_at, :datetime
  end
end

