class RemoveBookIdFromOrderedBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :ordered_books, :book_id, :integer
  end
end
