class RushVote < ActiveRecord::Base
  serialize :vote, Set
  validates_uniqueness_of :token
  validates_presence_of :token, :vote
end
