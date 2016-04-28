class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.text :css
      t.text :set
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
