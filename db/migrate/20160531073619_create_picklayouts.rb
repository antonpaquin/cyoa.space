class CreatePicklayouts < ActiveRecord::Migration
  def change
    create_table :picklayouts do |t|
      t.text :html
      t.string :title

      t.timestamps null: false
    end
  end
end
