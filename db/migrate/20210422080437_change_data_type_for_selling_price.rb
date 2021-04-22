class ChangeDataTypeForSellingPrice < ActiveRecord::Migration[6.1]
  def change
    def self.up
      change_table :ordered_books do |t|
        t.change :selling_price, :integer
      end
    end

    def self.down
      change_table :ordered_books do |t|
        t.change :selling_price, :decimal
      end
    end
  end
end
