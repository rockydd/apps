class AddOccurToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :occur_at, :datetime
  end

  def self.down
    remove_column :activities, :occur_at
  end
end
