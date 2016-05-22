class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :order_id
      t.boolean :accept
            t.references :order, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end
