class Relationship < ApplicationRecord
  #belongs_to :user
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

   def create_notification_follow(current_user)
    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end
end
