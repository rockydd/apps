class ThreadMessageStatusEx < ActiveRecord::Migration
  def self.up
    add_column :message_threads, :status, :string
    remove_column :messages, :status
  end

  def self.down
    remove_column :message_threads, :status
    add_column :messages, :status, :string
  end
end
