class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invitee_id
      t.integer :inviter_id
      t.integer :fantuan_id
      t.integer :status

      t.timestamps
    end
  end
end
