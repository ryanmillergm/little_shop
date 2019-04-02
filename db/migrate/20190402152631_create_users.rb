class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :role
      t.boolean :enabled
      t.string :email
      t.string :password_digest
      t.string :city
      t.string :state
      t.string :address
      t.string :zip
      t.timestamps
    end
  end
end
