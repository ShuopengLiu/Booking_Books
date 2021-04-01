class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
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
