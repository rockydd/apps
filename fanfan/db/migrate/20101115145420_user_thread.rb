class UserThread < ActiveRecord::Migration
  def self.up
    create_table :user_thread, :id => false do |t|
      t.references :users, :threads
    end
  end

  def self.down
    drop_table :user_thread
  end
end
