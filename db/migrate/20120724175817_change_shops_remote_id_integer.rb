class ChangeShopsRemoteIdInteger < ActiveRecord::Migration
  def change
    change_column :shops, :remote_id, :integer
  end
end
