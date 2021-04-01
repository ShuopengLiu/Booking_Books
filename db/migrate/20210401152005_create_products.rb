class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :book
      t.string :title
      t.string :author
      t.string :publisher
      t.text :description
      t.string :condition
      t.decimal :price

      t.timestamps
    end
  end
end
