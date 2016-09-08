class TracksController < ApplicationController

  before_action :force_login

  def new
    @track = Track.new
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:notice] = ["Created new track: #{@track.song}"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.save
      flash[:notice] = ["Edited: #{@track.song}"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    flash[:notice] = ["Deleted: #{@track.song}"]
    @track.delete
    redirect_to new_album_track_url
  end
  private
  def track_params
    params.require(:track).permit(:song, :album_id, :track_type, :lyrics)
  end
end
