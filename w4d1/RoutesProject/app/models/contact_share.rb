class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true, :uniqueness => {:scope => :contact_id}
  validates :contact, :user, presence: true
  
  belongs_to(:user)

  belongs_to(:contact)

end
