module ActivitiesHelper
  def readable_activity_status(activity)
    case activity.status
    when Activity::STATUS_NEW
      if activity.confirmed_by_user?(current_user)
        "Waiting for memebers to confirm"
      else
        "Waiting for you to confirm"
      end
    when Activity::STATUS_CLOSED
      "This activitiy has finished"
    else
      "Unknown status"
    end
  end

end
