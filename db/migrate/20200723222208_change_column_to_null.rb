class ChangeColumnToNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :images, :src, true
  end
end
