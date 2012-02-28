########################
# View all clients
########################
get '/clients' do
	_clients();
end

def _clients()
	clients = $dbh.select_all("SELECT * FROM clients ORDER BY SUBSTRING_INDEX(name,' ',-1);")

	if clients.empty? 
		@infos.merge!({:emptymsg=>"No clients were found in the system"})
	end
	erb :clients, :locals => { 
		:title => "Clients", 
		:clients => clients,
		:errors=>@errors, 
		:successes=>@successes, 
		:infos=>@infos, 
		:values=>@values
	}
end	


########################
# View 1 client
########################
get '/client/:id' do
	if params[:id].nil?
		session[:errors] = {:msg=>"Sorry, the client could not be found"}
		redirect '/clients'
	end
	client = $dbh.select_one("SELECT * FROM clients WHERE client_id=?",params[:id])
	erb :client, :locals => {
		:client => client,
		:errors=>@errors, 
		:successes=>@successes, 
		:infos=>@infos, 
		:values=>@values
	}	
end

########################
# Update a client 
########################
before '/client/update/:id' do
	validate_client(params)
	@ok = @errors.empty?
end

post '/client/update/:id' do
	$dbh.do("UPDATE clients SET name=?,email=?,comments=? WHERE client_id=?",params[:name],params[:email],params[:comments],params[:id]) if @ok
	session[:values] = params unless @errors.empty?
	session[:errors] = @errors unless @errors.empty?
	session[:successes] = {:msg=>"Client updated successfully"} if @errors.empty?
	redirect "/client/#{params[:id]}"
end

########################
# Create a client 
########################
before '/clients/new' do
	validate_client(params)
	@ok = @errors.empty?
end

post '/clients/new' do
	$dbh.do("INSERT INTO clients(name,email,comments) VALUES(?,?,?)",params[:name],params[:email],params[:comments]) if @ok
	session[:values] = params unless @errors.empty?
	session[:errors] = @errors unless @errors.empty?
	session[:successes] = {:msg=>"Client added successfully"} if @errors.empty?
	redirect '/clients'
end


	
########################
# Delete a client
########################

before '/clients/delete/:id' do
	unless /^\d+$/ =~ params[:id]
		@errors[:msg] = "Invalid client id"
	end
	@ok = @errors.empty?
end

get '/clients/delete/:id' do
	$dbh.do("DELETE FROM clients WHERE client_id=?",params[:id]) if @ok 
	session[:successes] = {:msg=>"Client deleted successfully"} if @errors.empty?
	redirect '/clients'
end


def validate_client(params)
	#Check for create
	if params[:name].nil? || params[:name].empty?
		@errors[:_name] = "The client's name must be set."
	elsif params[:name].length >= 100
		@errors[:_name] = "The client's name must be less than 100 characters."
	end
	
	if params[:email].nil? || params[:email].empty?
		@errors[:_email] = "The client's email address must be set."
	elsif params[:email].length >= 100
		@errors[:_email] = "The client's email address must be less than 100 characters."
	else
		params[:email].downcase!
	end
end

