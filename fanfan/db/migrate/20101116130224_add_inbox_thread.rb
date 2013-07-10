class AddInboxThread < ActiveRecord::Migration
  def self.up
    create_table :inbox_threads, :id => false do |t|
      t.references :user, :thread
    end
  end

  def self.down
    drop_table :inbox_threads
  end

end
