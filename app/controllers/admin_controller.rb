class AdminController < ApplicationController
  def index
    @elections = Election.all
  end
  
  def rush_index
    @rushes = Rush.all
  end
  
  def next_round
    @rushes = Rush.all
    @rushes.each do |rush|
      votes = rush.delib_votes
      yes = 0
      no = 0
      abstain = 0
      total = votes.count.to_f
      votes.each do |vote|
        if vote.vote == "Yes"
          yes += 1
        end
        if vote.vote =="No"
          no += 1
        end
        if vote.vote == "Abstain"
          abstain += 1
        end
        vote.destroy
      end
      percent_yes = yes.to_f / total
      percent_no = no.to_f / total
      percent_abstain = abstain.to_f / total
      @result = "INVALID DATA"
      if yes >= 43 && no < 8
        rush.destroy
      elsif no > 8
        rush.destroy
      end
    end
    redirect_to admin_url
  end
  
  
  def rush_results
    @rush = Rush.find_by_id(params[:id])
    @votes = @rush.delib_votes
    @yes = 0
    @no = 0
    @abstain = 0
    @total = @votes.count
    
    @votes.each do |vote|
      if vote.vote == "Yes"
        @yes += 1
      end
      if vote.vote =="No"
        @no += 1
      end
      if vote.vote == "Abstain"
        @abstain += 1
      end
    end
    @percent_yes = @yes.to_f / @total.to_f
    @percent_no = @no.to_f / @total.to_f
    @percent_abstain = @abstain.to_f / @total.to_f
    @result = "NO DATA"
    if @yes >= 36 && @no < 7
      @result = "ADMIT"
    elsif @no >= 7
      @result = "REJECT"
    else
      @result = "REVOTE"
    end
  end
  
  def all_rush_results
     @rushes = Rush.all
    @totals = {}
    @rushes.each do |rush|
      votes = rush.delib_votes
      @yes = 0
      @no = 0
      @abstain = 0
      total = votes.count.to_f
      votes.each do |vote|
        if vote.vote == "Yes"
          @yes += 1
        end
        if vote.vote =="No"
          @no += 1
        end
        if vote.vote == "Abstain"
          @abstain += 1
        end
      end
      percent_yes = @yes.to_f / total
      percent_no = @no.to_f / total
      percent_abstain = @abstain.to_f / total
      @result = "INVALID DATA"
      if @yes >= 36 && @no < 7
        @result = "ADMIT"
      elsif @no >= 7
        @result = "REJECT"
      else
        @result = "REVOTE"
      end
      @totals[rush.name] =  [@result, total, @no, @yes, @abstain]
    end
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
