class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_type
      t.string :restaurant
      t.text :menu_image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
