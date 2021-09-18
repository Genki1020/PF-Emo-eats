class PostCommentsController < ApplicationController
  def create
    eatery = Eatery.find(params[:eatery_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.eatery_id = eatery.id
    comment.save
    redirect_to eatery_path(eatery)
  end

  def destroy
    eatery = Eatery.find(params[:eatery_id])
    PostComment.find_by(id: params[:id], eatery_id: params[:eatery_id]).destroy
    redirect_to eatery_path(params[:eatery_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
