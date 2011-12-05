class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :election_id
      t.integer :user
      t.string :token
      t.binary :vote

      t.timestamps
    end
  end
end
