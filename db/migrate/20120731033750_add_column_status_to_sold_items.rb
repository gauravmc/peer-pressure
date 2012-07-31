class AddColumnStatusToSoldItems < ActiveRecord::Migration
  def change
    add_column :sold_items, :status, :string
  end
end
