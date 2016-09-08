class AlbumsController < ApplicationController

  before_action :force_login
  
  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = ["Created new album: #{@album.title}"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = ["Edited: #{@album.title}"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band_id = @album.band_id
    flash[:notice] = ["Deleted: #{@album.title}"]
    @album.delete
    redirect_to band_url(band_id)
  end
  private
  def album_params
    params.require(:album).permit(:title, :band_id, :record_type)
  end
end
