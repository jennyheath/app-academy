class Visits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :short_url_id, presence: true
      t.string :email_id, presence: true

      t.timestamps
    end
  end
end
