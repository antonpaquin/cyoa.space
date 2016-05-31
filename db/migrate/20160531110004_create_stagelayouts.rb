class CreateStagelayouts < ActiveRecord::Migration
  def change
    create_table :stagelayouts do |t|
      t.text :html
      t.string :title
      t.integer :adventure_id

      t.timestamps null: false
    end
  end
end
