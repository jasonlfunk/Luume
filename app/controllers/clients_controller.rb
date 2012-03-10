class ClientsController < ApplicationController
  before_filter :login_required
 
  # GET /clients
  # GET /clients.json
  def index
    @clients = @current_user.clients

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
    
    if @client.user == @current_user
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @client }
      end
    else
      respond_to do |format|
        format.html { redirect_to clients_path, :notice => "Sorry, you don't have access to that client." }
        format.json { render :status => 403 }
      end
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    logger.error("Beta failed! Setting flash")
    logger.info("Beta failed! Setting flash")
    logger.debug("Beta failed! Setting flash")

    if params[:beta_secret]
      if params[:beta_secret] !=~ /[A-Z]{4}[0-9]{3}/
        beta_fail = true
      end
    else
      beta_fail = true
    end
    
    if beta_fail 
      flash.now[:error] = "Your beta code was invalid."
      respond_to do |format|
        format.html { render :action => "new" }
        format.json { render :json => @client.errors, :status => :unprocessable_entity }
      end
    else
      @client = Client.new(params[:client])

      respond_to do |format|
        if @client.save
          format.html { redirect_to @client, :notice => 'Client was successfully created.' }
          format.json { render :json => @client, :status => :created, :location => @client }
        else
          format.html { render :action => "new" }
          format.json { render :json => @client.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, :notice => 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
  
end
