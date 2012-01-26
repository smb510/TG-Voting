class RushesController < ApplicationController
  # GET /rushes
  # GET /rushes.json
  def index
    @rushes = Rush.all

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
  
  =begin
  def many_rushes_new
    @rush_string = params[:rushes]
    @rush_string = @rush_string.split('\n')
    @rush_string.each do |rush|
      @rush = Rush.new
      @rush.name = rush
      @rush.save
    end
     respond_to do |format|
        if @rush.save
          format.html { redirect_to rushes_url, :notice => 'Rushes was successfully created.' }
          format.json { render :json => @rush, :status => :created, :location => @rush }
        else
          format.html { render :action => "new" }
          format.json { render :json => @rush.errors, :status => :unprocessable_entity }
        end
      end
  end
  =end
  

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
end
