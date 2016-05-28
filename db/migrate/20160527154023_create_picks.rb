class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :title
      t.string :pick
      t.text :content
      t.text :only_if
      t.text :sets
      t.integer :picklayout_id

      t.timestamps null: false
    end
  end
end
