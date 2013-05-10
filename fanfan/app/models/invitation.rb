class Invitation < ActiveRecord::Base
  validates_presence_of :inviter_id, :invitee_id, :fantuan_id, :status
end
