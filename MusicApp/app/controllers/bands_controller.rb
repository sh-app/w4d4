class BandsController < ApplicationController

  before_action :force_login

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:notice] = ["Created new band: #{@band.name}"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])

    if @band.save
      flash[:notice] = ["Edited band: #{@band.name}"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end
  def update

  end

  def destroy
    @band = Band.find(params[:id])
    flash[:notice] = ["Deleted: #{@band.name}"]
    @band.delete
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
