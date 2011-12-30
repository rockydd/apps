
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
end
