class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def edit
    @tracks = Tracks.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to @track
    else
      render 'edit'
    end
  end

  def show
    @track = Track.find(params[:id])
    # @user = @track.user
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    # @track.user = current_user
    if @track.save
      redirect_to track_path(@track)
    else
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_path
  end

  private

  def track_params
    params.require(:track).permit(:title, :artist, :photo_link, :video_link)
  end
end
