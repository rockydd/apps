
# CREATE TABLE "payments" (
# "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
# "activity_id" integer, 
# "user_id" integer, 
# "amount" decimal, 
# "final" boolean, 
# "confirmed" boolean
# );
class Payment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
#  validates_uniqueness_of :user_id, :scope => :activity_id, :message => "Duplicate user found"
  def editable_by_user?(editing_user)
    if self.user == activity.creator
      return false
    end

    return editing_user.is_creator_of?(activity) || editing_user == self.user 
  end
end
