class AddRemoteIdToSoldItems < ActiveRecord::Migration
  def change
    add_column :sold_items, :remote_id, :integer
  end
end
