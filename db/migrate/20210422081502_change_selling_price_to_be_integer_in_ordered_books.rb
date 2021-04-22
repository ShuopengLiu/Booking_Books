class ChangeSellingPriceToBeIntegerInOrderedBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :ordered_books, :selling_price, :integer
  end
end
