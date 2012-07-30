class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :domain
      t.string :name
      t.string :owner
      t.string :token
      t.integer :remote_id

      t.timestamps
    end
  end
end
