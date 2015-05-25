class Contact < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => {:scope => :user_id}
  validates :name, :email, :owner, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id
  )

  has_many(:contact_shares, dependent: :destroy)

  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )

  # def self.contacts_for_user_id(user_id)
end
