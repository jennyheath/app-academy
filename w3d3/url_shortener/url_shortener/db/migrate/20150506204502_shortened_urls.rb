class ShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, { presence: true, unique: true }
      t.string :short_url, { presence: true, unique: true }
      t.integer :submitter_id, { presence: true, unique: true }
    end

    add_index :shortened_urls, :submitter_id
    add_index :shortened_urls, :short_url#, unique: true
  end
end
