require 'set'

class RushVoteController < ApplicationController
  skip_before_filter :authorize_admin, :only => [select, vote]
  def new
     @rushvote = RushVote.new

     respond_to do |format|
       format.html # new.html.erb
       format.json { render :json => @rush }
     end
   end
   
  def select
    @rush = Rush.all
    @rush_list = []
    @rush.each do |rush|
      @rush_list << rush.name
    end
  end

  def vote
    @rushvote = RushVote.new
     #set user token so that no user can vote more than once.
     @rushvote.token = session[:user_id].to_s

     @set = Set.new()
     @set.add(params[:choice1])
     @set.add(params[:choice2])
     @set.add(params[:choice3])
     @set.add(params[:choice4])
     @set.add(params[:choice5])
     @set.add(params[:choice6])
     @set.add(params[:choice7])
     @rushvote.vote = @set
     if @rushvote.save
       flash[:notice] = "Selections Recorded. Thank you"
       redirect_to thanks_url
     else
       flash[:error] = "Error. Try Again."
       redirect_to rushvotes_url
     end
    
  end

  def tally
    @rushes = RushVote.all
    @votes = {}
    @rushes.each do |rush|
      rush.vote.each do |rush_vote|
        if @votes[rush_vote] == nil
          @votes[rush_vote] = 1
        else
          @votes[rush_vote] += 1
        end
      end
    end
  end
  #@votes.sort_by {|name, count| name}

end
