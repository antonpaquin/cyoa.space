class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :adventure_id
      t.attachment :image
      t.string :name

      t.timestamps null: false
    end
  end
end
