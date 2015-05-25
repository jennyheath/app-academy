class User < ActiveRecord::Base
  validates :username, presence: true

  has_many(
    :contacts, dependent: :destroy,
    class_name: "Contact",
    foreign_key: :user_id
  )

  has_many(:contact_shares, dependent: :destroy)

  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

end
