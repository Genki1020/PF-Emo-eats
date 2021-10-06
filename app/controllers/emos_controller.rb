class EmosController < ApplicationController
   def index
    @emos = Emo.all
    @emo = Emo.new
  end

  def new
    @emo_new = Emo.new
  end

  def create
    @emo = Emo.new(emo_params)
    @emo.save
    redirect_to request.referer
  end

  def edit
    @emo = Emo.find(params[:id])
  end

  def update
    @emo= Emo.find(params[:id])
    @emo.update(emo_params)
    redirect_to admin_emos_path
  end

  def destroy
    @emo = Emo.find(params[:id])
    @emo.destroy
    redirect_to emos_path
  end

private

  def emo_params
    params.require(:emo).permit(:emo_name)
  end
end