class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :adventure_id
      t.text :name
      t.text :css
      t.text :only_if

      t.timestamps null: false
    end
  end
end
