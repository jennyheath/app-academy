class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact, status: :created
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    destroyed_contact = Contact.destroy(params[:id])
    render json: destroyed_contact
  end

  def index
    user = User.find(params[:user_id])
    render  json: (user.contacts + user.shared_contacts)
    # @contacts = Contact.all
    # render json: @contacts
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end

end
