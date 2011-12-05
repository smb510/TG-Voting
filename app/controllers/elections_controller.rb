class ElectionsController < ApplicationController
  # GET /elections
  # GET /elections.json
  skip_before_filter :authorize_admin, :only => [:index, :irv_vote]
  skip_before_filter :authorize, :only => [:irv_vote]
  
  def index
    @election = Election.where("open = ?", true).first
    @user = User.find_by_id(session[:user_id])
    @candidate_list = [@election.candidate1, @election.candidate2, @election.candidate3, @election.candidate4, @election.candidate5]
    @candidates_list.delete("")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @elections }
    end
  end
  
  def irv_vote
    @election = Election.find_by_id(params[:election])
    pref_list = []
    pref_list << params[:first_choice]
    pref_list << params[:second_choice]
    if params[:third_choice] != nil
       pref_list << params[:third_choice]
     end
     if params[:fourth_choice] != nil
      pref_list << params[:fourth_choice]
    end
      if params[:fifth_choice] != nil
         pref_list << params[:fifth_choice]
       end
    @vote = @election.votes.build(:user => session[:user_id], :vote => pref_list, :token => session[:user_id].to_s + "#" + @election.id.to_s)
    if @vote.save
      if request.xhr?
        render :status => 200, :text => "Vote was successful."
      else
        redirect_to elections_url, :notice => "Vote Was successful."
      end
    else
      if request.xhr?
        render :status => 403, :text => "Error. Vote was not recorded.  Please reload and try again."
      else
        redirect_to elections_url, :text => "Error. Vote was not recorded.  Please reload and try again."
      end
    end
  end

  # GET /elections/1
  # GET /elections/1.json
  def show
    @election = Election.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @election }
    end
  end

  # GET /elections/new
  # GET /elections/new.json
  def new
    @election = Election.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @election }
    end
  end

  # GET /elections/1/edit
  def edit
    @election = Election.find(params[:id])
  end

  # POST /elections
  # POST /elections.json
  def create
    @election = Election.new(params[:election])

    respond_to do |format|
      if @election.save
        format.html { redirect_to @election, :notice => 'Election was successfully created.' }
        format.json { render :json => @election, :status => :created, :location => @election }
      else
        format.html { render :action => "new" }
        format.json { render :json => @election.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /elections/1
  # PUT /elections/1.json
  def update
    @election = Election.find(params[:id])

    respond_to do |format|
      if @election.update_attributes(params[:election])
        format.html { redirect_to @election, :notice => 'Election was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @election.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def toggle_open_state
    @election = Election.find_by_id(params[:id])
      if params[:state] == "Open"
        @election.open = true
      elsif params[:state] == "Close"
        @election.open = false
      end
      @election.save
      redirect_to admin_url
  end

  # DELETE /elections/1
  # DELETE /elections/1.json
  def destroy
    @election = Election.find(params[:id])
    @election.destroy

    respond_to do |format|
      format.html { redirect_to elections_url }
      format.json { head :ok }
    end
  end
end
