class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,         null: false
      t.string :last_name,          null: false
      t.string :first_name_kana,    null: false
      t.string :last_name_kana,     null: false
      t.string :zipcode
      t.string :prefecture 
      t.string :municipalitie
      t.string :address
      t.string :address_other
      t.string	 :tell
      t.references :user
      t.timestamps
    end
  end
end
