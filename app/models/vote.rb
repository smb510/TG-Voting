class Vote < ActiveRecord::Base
  serialize :vote, Array
  validates_uniqueness_of :token
  belongs_to :election
  
  
  def removeCandidate(name)
    vote.delete(candidate)
  end
end
