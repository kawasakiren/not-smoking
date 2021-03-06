class CreateFollowRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_requests do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
