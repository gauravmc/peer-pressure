class AddHandleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :handle, 'VARCHAR(255)'
  end
end
