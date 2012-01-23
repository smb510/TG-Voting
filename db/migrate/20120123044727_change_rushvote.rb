class ChangeRushvote < ActiveRecord::Migration
  def up
    add_column :rush_votes, :vote, :text
  end

  def down
    remove_column :rush_votes, :vote
  end
end
