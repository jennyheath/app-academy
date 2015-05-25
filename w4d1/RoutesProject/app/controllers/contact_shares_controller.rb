class ContactSharesController < ApplicationController
  def create
    @contact_share = ContactShare.new(contact_share_params)
    render json: @contact_share
  end

  def destroy
    destroyed_contact_share = ContactShare.destroy(params[:id])
    render json: destroyed_contact_share
  end

  private

  def contact_share_params
    params[:contact_share].permit(:contact_id, :user_id)
  end

end
