class CreateSoldItems < ActiveRecord::Migration
  def change
    create_table :sold_items do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :shop_id

      t.timestamps
    end
  end
end
