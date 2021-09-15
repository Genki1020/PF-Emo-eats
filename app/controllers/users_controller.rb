class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
      if @user == current_user
          render "edit"
      else
          redirect_to eateriess_path
      end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "レポートを更新しました！"
    redirect_to user_path(@user)
    else
    flash[:notice] = "eatery was errored."
    render :edit
    end
  end

     private

  def user_params
    params.require(:user).permit(:name, :furigana,:account,:address, :postal_code,:prefecture,:telephone_number,:profile_image)
  end
end
