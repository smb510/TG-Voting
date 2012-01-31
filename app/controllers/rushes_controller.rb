class RushesController < ApplicationController
  # GET /rushes
  # GET /rushes.json
  def index
    @rushes = Rush.where("open= ?", true)
    @user = user.find_by(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rushes }
    end
  end

  # GET /rushes/1
  # GET /rushes/1.json
  def show
    @rush = Rush.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rush }
    end
  end

  # GET /rushes/new
  # GET /rushes/new.json
  def new
    @rush = Rush.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @rush }
    end
  end

  # GET /rushes/1/edit
  def edit
    @rush = Rush.find(params[:id])
  end

  # POST /rushes
  # POST /rushes.json
  def create
    @rush = Rush.new(params[:rush])
    @rush.open = false

    respond_to do |format|
      if @rush.save
        format.html { redirect_to @rush, :notice => 'Rush was successfully created.' }
        format.json { render :json => @rush, :status => :created, :location => @rush }
      else
        format.html { render :action => "new" }
        format.json { render :json => @rush.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rushes/1
  # PUT /rushes/1.json
  def update
    @rush = Rush.find(params[:id])

    respond_to do |format|
      if @rush.update_attributes(params[:rush])
        format.html { redirect_to @rush, :notice => 'Rush was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @rush.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /rushes/1
  # DELETE /rushes/1.json
  def destroy
    @rush = Rush.find(params[:id])
    @rush.destroy

    respond_to do |format|
      format.html { redirect_to rushes_url }
      format.json { head :ok }
    end
  end
  
  def vote
    @rush = Rush.find_by_id(params[:id])
    @vote = @rush.delib_votes.build(:user => session[:user_id], :vote => params[:vote], :token => session[:user_id].to_s + "#" + @rush.id.to_s)
    if @vote.save
      if request.xhr?
        render :status => 200, :text = @vote.vote
      else
        redirect_to rushes_url, :notice => "Your vote was recorded."
      end
    else
      if request.xhr?
        render :status => 403, :text => "Error."
      else
        redirect_to rushes_url, :error => "Vote not accepted."
      end
    end
  end
  
  def toggle_open_state
    @rush = Rush.find_by_id(params[:id])
        if params[:state] == "Open"
          @rush.open = true
        elsif params[:state] == "Close"
          @rush.open = false
        end
        @rush.save
        redirect_to admin_url
    end
  end
  
  def open_all
    @rushes = Rush.all
    @rushes.each do |rush|
      rush.open = true
      rush.save
    end
    redirect_to admin_url, :notice => "All Rushes Now Open For Voting"
  end
  
  def close_all
    @rushes = Rush.all
    @rushes.each do |rush|
      rush.open = false
      rush.save
    end
    redirect_to admin_url, :notice => "All Rushes Now Closed for Voting"
  end
    
  
  
end
