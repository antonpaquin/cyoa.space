class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :pick
      t.text :title
      t.text :content
      t.text :only_if
      t.text :sets
      t.integer :picklayout_id
      t.integer :stage_id

      t.timestamps null: false
    end
  end
end
