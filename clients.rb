before '/clients' do
	logger.info "in clients"
	if env["REQUEST_METHOD"] == "POST"
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
		@ok = @errors.empty?
	else
		#GET is always okay!
		@ok = 1
	end
end

post '/clients' do
	$dbh.do("INSERT INTO clients(name,email,comments) VALUES(?,?,?)",params[:name],params[:email],params[:comments]) if @ok
	@values.merge!(params) unless @errors.empty?
	@successes.merge!({:msg=>"Client added successfully"}) if @errors.empty?
	_clients()
end

before '/clients/delete/:id' do
	unless /^\d+$/ =~ params[:id]
		@errors[:msg] = "Invalid client id"
	end
	@ok = @errors.empty?
end

get '/clients/delete/:id' do
	$dbh.do("DELETE FROM clients WHERE client_id=?",params[:id]) if @ok 
	session[:successes] = {:msg=>"Client deleted successfully"} if @errors.empty?
	redirect '/'
end

get '/clients' do
	_clients();
end

def _clients()
	clients = $dbh.select_all("SELECT * FROM clients")

	if clients.empty? 
		@infos.merge!({:emptymsg=>"No clients were found in the system"})
	end
	erb :clients, :locals => { 
		:title => "Clients", 
		:clients => clients,
		:errors=>@errors, 
		:successes=>@successes, 
		:infos=>@infos, 
		:values=>@values||={}
	}
end	
