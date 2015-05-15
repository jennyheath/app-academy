class BandsController < ApplicationController
  before_action :verify_logged_in

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      @band = Band.new(band_params)
      render :new
    end
  end

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def show
    @band = Band.find(params[:id])
    if @band
      render :show
    else
      flash[:errors] = ["This band does not exist"]
      redirect_to bands_url
    end
  end

  def edit
    @band = Band.find(params[:id])
    if @band
      render :edit
    else
      flash[:errors] = ["This band does not exist"]
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      @band = Band.new(band_params)
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def verify_logged_in
    if current_user.nil?
      flash[:errors] = ["Please log in."]
      redirect_to new_session_url
    end
  end
end
