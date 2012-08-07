class CreateFeedboxes < ActiveRecord::Migration
  def change
    create_table :feedboxes do |t|
      t.integer :shop_id
      t.string :item_background
      t.string :item_border
      t.string :box_background
      t.string :box_border

      t.timestamps
    end
  end
end
