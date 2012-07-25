class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.text :img_url
      t.integer :shop_id
      t.integer :remote_id

      t.timestamps
    end
  end
end
