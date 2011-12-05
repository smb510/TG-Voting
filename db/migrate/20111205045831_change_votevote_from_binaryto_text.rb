class ChangeVotevoteFromBinarytoText < ActiveRecord::Migration
  def up
    change_column(:votes, :vote, :text)
  end

  def down
    change_column(:votes, :vote, :binary)
  end
end
