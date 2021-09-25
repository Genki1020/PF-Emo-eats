class FavoritesController < ApplicationController
  def create
    @eatery = Eatery.find(params[:eatery_id])
    favorite = current_user.favorites.new(eatery_id: @eatery.id)
    favorite.save
    @eatery.create_notification_favorite!(current_user)
  end

  def destroy
    @eatery = Eatery.find(params[:eatery_id])
    favorite = current_user.favorites.find_by(eatery_id: @eatery.id)
    favorite.destroy
  end
end
