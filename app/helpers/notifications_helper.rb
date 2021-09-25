module NotificationsHelper
   def notification_form(notification)
      @visitor = notification.visitor
      @post_comment = nil
      your_eatery = link_to 'あなたの投稿', eatery_path(notification), style:"font-weight: bold;"
      @visitor_post_comment = notification.post_comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "favorite" then
          tag.a(notification.visitor.account, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:eatery_path(notification.eatery_id), style:"font-weight: bold;")+"にいいねしました"
        when "post_comment" then
            @post_comment = PostComment.find_by(id: @visitor_post_comment)&.comment
            tag.a(@visitor.account, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:eatery_path(notification.eatery_id), style:"font-weight: bold;")+"にコメントしました"
      end
    end
end
