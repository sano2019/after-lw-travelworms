class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :asker, foreign_key: {to_table: :users}
      t.references :receiver, foreign_key: {to_table: :users}
      t.string :status

      t.timestamps
    end
  end
end
