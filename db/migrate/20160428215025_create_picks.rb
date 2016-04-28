class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :stage_id
      t.text :title
      t.text :description
      t.text :css
      t.text :class
      t.text :only_if
      t.text :sets

      t.timestamps null: false
    end
  end
end
