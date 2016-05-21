class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :order_id
      t.integer :friend_id

      t.timestamps null: false
    end
  end
end
