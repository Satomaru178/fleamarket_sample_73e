class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :name
      t.text    :explain
      t.integer :condition_id
      t.integer :costburden_id
      t.integer :shippingorigin_id
      t.integer :shippingperiod_id
      t.integer :price
      t.timestamps
    end
  end
end
