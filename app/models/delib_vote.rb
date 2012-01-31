class DelibVote < ActiveRecord::Base
  belongs_to :rush
  validates_uniqueness_of :token
  validates_presence_of :token, :rush_id, :user, :vote
end
