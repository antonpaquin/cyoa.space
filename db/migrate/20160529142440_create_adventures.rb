class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.text :css
      t.text :set
      t.text :verify
      t.string :title
      t.text :description
      t.integer :playcount
      t.integer :stagecount
      t.float :rating
      t.integer :ratecount
      t.integer :favorites
      t.integer :account_id
      t.boolean :public

      t.timestamps null: false
    end
  end
end
