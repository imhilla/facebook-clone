class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :requester_user, null: false,  foreign_key: { to_table: :users }
      t.references :reciever_user, null: false,  foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
