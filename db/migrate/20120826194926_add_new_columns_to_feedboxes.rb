class AddNewColumnsToFeedboxes < ActiveRecord::Migration
  def change
    add_column :feedboxes, :font_size, :string
    add_column :feedboxes, :image_size, :string
    add_column :feedboxes, :box_width, :string
    add_column :feedboxes, :box_height, :string
    add_column :feedboxes, :scrollbar, :boolean
    add_column :feedboxes, :shadow, :boolean
  end
end
