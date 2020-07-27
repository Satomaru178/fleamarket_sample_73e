class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string     :name
      t.text       :explain
      t.integer    :condition_id
      t.integer    :costburden_id
      t.integer    :shippingorigin_id
      t.integer    :shippingperiod_id
      t.integer    :price
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :buyer,               foreign_key: { to_table: :users }
      t.references :category,            foreign_key: true
      t.references :brand,               foreign_key: true
      t.timestamps
    end
  end
end
