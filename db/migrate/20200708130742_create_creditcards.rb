class CreateCreditcards < ActiveRecord::Migration[5.0]
  def change
    create_table :creditcards do |t|
      t.references :user,          null: false, forign_key: true
      t.string :customer_id, null: false
      t.string :card_id, null: false
      t.timestamps
    end
  end
end
