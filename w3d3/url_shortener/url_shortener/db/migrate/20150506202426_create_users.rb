class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, { presence: true, unique: true } #, index: true

      t.timestamps
    end

    add_index :users, :email
  end
end
