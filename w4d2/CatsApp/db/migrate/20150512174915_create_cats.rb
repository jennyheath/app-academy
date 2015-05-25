class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.datetime :birth_date, null: false
      t.string :color, null: false
      t.string :name, null: false, index: true
      t.string :sex, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
