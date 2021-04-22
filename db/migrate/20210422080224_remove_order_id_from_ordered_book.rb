class RemoveOrderIdFromOrderedBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :ordered_books, :order_id, :integer
  end
end
