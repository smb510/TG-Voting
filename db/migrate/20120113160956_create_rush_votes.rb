class CreateRushVotes < ActiveRecord::Migration
  def change
    create_table :rush_votes do |t|
      t.string :token

      t.timestamps
    end
  end
end
