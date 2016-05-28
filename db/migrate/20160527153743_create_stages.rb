class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :title
      t.text :content
      t.integer :adventure_id
      t.integer :stagelayout_id
      t.integer :order

      t.timestamps null: false
    end
  end
end
