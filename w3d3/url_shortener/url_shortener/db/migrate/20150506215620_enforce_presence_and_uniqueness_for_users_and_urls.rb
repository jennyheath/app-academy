class EnforcePresenceAndUniquenessForUsersAndUrls < ActiveRecord::Migration
  def change
    change_column(:users, :email, :string, null: false)
    change_column(:shortened_urls, :long_url, :string, null: false)
    change_column(:shortened_urls, :short_url, :string, null: false)
    change_column(:shortened_urls, :submitter_id, :string, null: false)

    remove_index(:users, column: :email)
    add_index(:users, :email, unique: true)
    remove_index(:shortened_urls, column: :short_url)
    add_index(:shortened_urls, :short_url, unique: true)
    remove_index(:shortened_urls, column: :submitter_id)
    add_index(:shortened_urls, :submitter_id, unique: true)
  end
end
