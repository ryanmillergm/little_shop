class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :nickname
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :primary
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
    end
  end
end
