class CreateOrderedBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_books do |t|
      t.integer :quantity
      t.decimal :selling_price
      t.references :book, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
