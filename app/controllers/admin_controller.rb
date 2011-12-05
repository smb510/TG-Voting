class AdminController < ApplicationController
  def index
    @elections = Election.all
  end

  def raw_results
    @votes = Election.find_by_id(params[:id]).votes
    @raw_results = {}
    @votes.each do |vote|
      count = vote.vote.count
      i = 0
      for i in 0..count-1
        if @raw_results[vote.vote[i]] == nil
          @raw_results[vote.vote[i]] = []
          count.times do
            @raw_results[vote.vote[i]] << 0
          end
          @raw_results[vote.vote[i]][i] += 1
        else
          @raw_results[vote.vote[i]][i] += 1
        end
      end
    end
  end

  def irv_calc
    @name = Election.find_by_id(params[:id]).position
    @votes = Election.find_by_id(params[:id]).votes
    @total_votes = @votes.count
    win = false
    while !win
      @results = {}
      @votes.each do |vote|
        if @results[vote.vote[0]] == nil
          @results[vote.vote[0]] = 1
        else
          @results[vote.first]+=1
        end
      end
      @results = @results.sort {|candidate, count| count[1] <=> candidate[1]}
      @highest = @results[0]
      if @highest[1] * 2 > @total_votes
        @winner = @highest[0]
        win = true
      else
        @lowest = @results.select{|x| x[1] == @results.last[1]}
        @votes.each do |vote|
          @lowest.each do |least|
            vote.vote.removeCandidate(least)
          end
        end
      end
    end
  end

  def poll_calc
    @votes = Election.find_by_id(params[:id]).votes
     @results = {}
      @votes.each do |vote|
        if @results[vote.vote[0]] == nil
          @results[vote.vote[0]] = 1
        else
          @results[vote.first]+=1
        end
      end
      @total_count = Float(@votes.count)
      @results = @results.sort {|candidate, count| count[1] <=> candidate[1]}
      @results.each do |result|
        if(result[1] > 0)
        result[1] = Float(result[1]) / @total_count * 100
      end
      end
  end

end
