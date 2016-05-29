class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :pass_hash
      t.string :salt
      t.integer :usergroup

      t.timestamps null: false
    end
  end
end
