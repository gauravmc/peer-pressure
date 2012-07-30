class ChangeShopsRemoteIdInteger < ActiveRecord::Migration
  def change
    change_column :shops, :remote_id, 'INTEGER(11)'
  end
end
