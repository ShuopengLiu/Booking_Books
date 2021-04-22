class AddBookRefToOrderedBooks < ActiveRecord::Migration[6.1]
  def change
    add_reference :ordered_books, :book, null: false, foreign_key: true
  end
end
