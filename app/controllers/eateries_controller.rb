class EateriesController < ApplicationController
  def new
     @eatery = Eatery.new
  end

  def create
    @eatery = Eatery.new(eatery_params)
    @eatery.user_id = current_user.id
    if @eatery.save
      flash[:notice] = "投稿完了"
      redirect_to eateries_path
    else
      render :new
    end
  end

  def index
    @eateries = Eatery.page(params[:page]).reverse_order
    @all_ranks = Eatery.find(Favorite.group(:eatery_id).order('count(eatery_id) desc').limit(3).pluck(:eatery_id))
  end

  def show
    @eatery = Eatery.find(params[:id])
    @post_comment = PostComment.new
    gon.eatery = @eatery
  end

  def edit
      @eatery =  Eatery.find(params[:id])
      if @eatery.user == current_user
          render "edit"
      else
          redirect_to eateriess_path
      end
  end

    def update
    @eatery = Eatery.find(params[:id])
    if @eatery.update(eatery_params)
    flash[:notice] = "レポートを更新しました！"
    redirect_to eatery_path(@eatery)
    else
    flash[:notice] = "eatery was errored."
    render :edit
    end
  end

  def destroy
    @eatery = Eatery.find(params[:id])
    @eatery.destroy
    redirect_to eateries_path
  end

 def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
end

  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      eatery_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

   private

  def eatery_params
    params.require(:eatery).permit({images: []}, :user_id,:eatery_name,:address,:emo_id,:report,:emo)
  end

end

