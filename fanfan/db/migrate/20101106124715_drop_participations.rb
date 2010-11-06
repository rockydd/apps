class DropParticipations < ActiveRecord::Migration
  def self.up
    drop_table :participations
  end

  def self.down
    create_table :participations do |t|
      t.integer :activity_id
      t.integer :user_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
