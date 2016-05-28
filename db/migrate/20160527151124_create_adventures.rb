class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :title
      t.text :css
      t.text :set
      t.text :verify
      t.text :description

      t.timestamps null: false
    end
  end
end
