class Rush < ActiveRecord::Base
  has_many :delib_votes, :dependent => :delete_all
  validates_presence_of :name
end
