post '/login' do
	if params[:user] then
		session[:user] = params[:user]
	end
	redirect '/'
end

get '/logout' do
	if session[:user] then
		session.delete(:user)
	end
	redirect '/'
end
