class FavoritesController < ApplicationController
  def create
    eatery = Eatery.find(params[:eatery_id])
    favorite = current_user.favorites.new(eatery_id: eatery.id)
    favorite.save
    redirect_to eatery_path(eatery)
  end

  def destroy
    eatery = Eatery.find(params[:eatery_id])
    favorite = current_user.favorites.find_by(eatery_id: eatery.id)
    favorite.destroy
    redirect_to eatery_path(eatery)
  end
end
