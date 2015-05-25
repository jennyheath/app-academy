class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.approve!
      flash[:notice] = "Cat approved!"
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      # ?
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      redirect_to cat_url(@cat_rental_request.cat_id)
    end
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.deny!
      flash[:notice] = "Cat denied!"
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      # ?
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      redirect_to cats_url(@cat_rental_request.cat_id)
    end
  end

  private
    def current_cat_rental_request
      @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id])
    end

    def current_cat
      current_cat_rental_request.cat
    end

    def cat_rental_request_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    end
end
