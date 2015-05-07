class EnforcePresenceForVisits < ActiveRecord::Migration
  def change
    change_column(:visits, :short_url_id, :integer, null: false)
    change_column(:visits, :email_id, :integer, null: false)
  end
end
