class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text       :comment,     null: false
      t.references :user,        null: false, foreign_key: true
      t.references :product,     null: false, foreign_key: true
      t.integer    :delete_check,default: 0
      t.timestamps
    end
  end
end
