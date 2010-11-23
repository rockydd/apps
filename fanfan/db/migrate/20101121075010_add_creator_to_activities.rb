class AddCreatorToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :creator_id, :integer
  end

  def self.down
    remove_column :activities, :creator_id
  end
end
