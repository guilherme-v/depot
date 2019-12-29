class AddProductPriceToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :product_price, :decimal, precision: 8, scale: 2

    # copy all products prices to new column
    LineItem.all.each do |li|
      li.product_price = li.product.price
      li.save!
    end
  end
end
