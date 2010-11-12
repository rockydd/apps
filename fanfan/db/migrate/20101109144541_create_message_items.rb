class CreateMessageItems < ActiveRecord::Migration
  def self.up
    create_table :message_items do |t|
      t.timestamp :sent_date
      t.text :content
      t.integer :message_id

      t.timestamps
    end
  end

  def self.down
    drop_table :message_items
  end
end
