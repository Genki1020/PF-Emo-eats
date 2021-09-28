class EateriesController < ApplicationController
  def new
     @eatery = Eatery.new
     @emo = Emo.new
  end

  def create
    @eatery = Eatery.new(eatery_params)
    @emo = Emo.new(emo_params)
    @eatery.user_id = current_user.id
    if @eatery.save
      flash[:notice] = "投稿完了"
      redirect_to eateries_path
    elsif
      @emo.save
      redirect_to request.referer
    else
      render :new
    end
  end

  def index
    @eateries = Eatery.page(params[:page]).reverse_order
    @all_ranks = Eatery.find(Favorite.group(:eatery_id).order('count(eatery_id) desc').limit(3).pluck(:eatery_id))
    @emos = Emo.all
    @user = current_user
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


   private

  def eatery_params
    params.require(:eatery).permit({images: []}, :user_id,:eatery_name,:address,:emo_id,:report,:emo)
  end
 def emo_params
    params.require(:emo).permit(:emo_name)
  end
end

