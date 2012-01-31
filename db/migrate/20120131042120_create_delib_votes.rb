class CreateDelibVotes < ActiveRecord::Migration
  def change
    create_table :delib_votes do |t|
      t.integer :rush_id
      t.integer :user
      t.string :vote
      t.string :token

      t.timestamps
    end
  end
end
