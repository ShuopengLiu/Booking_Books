class ChangeProvinceFKnull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :province_id, true
  end
end
