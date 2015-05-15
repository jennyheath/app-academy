class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    @album.destroy
    redirect_to band_url(@band)
  end

  def edit
    @album = Album.find(params[:id])
    if @album
      render :edit
    # else
    #   flash[:errors] = ["This album does not exist"]
    #   redirect_to bands_url
    end
  end

  def new
    @album = Album.new
    render :new
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      @album = Album.new(album_params)
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    if @album
      render :show
    # else
    #   flash[:errors] = ["This album does not exist"]
    #   redirect_to bands_url
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :recording_type)
  end
end
