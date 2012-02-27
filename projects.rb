post '/projects' do
	$dbh.do("INSERT INTO projects(name) VALUES(?)",params[:name]) if !params[:name].nil? && params[:name].length > 0 
	redirect '/projects'
end

get '/projects/delete/:id' do
	$dbh.do("DELETE FROM projects WHERE project_id=?",params[:id]) if /^\d+$/ =~ params[:id]
	redirect '/projects'
end

get '/projects' do
	projects = $dbh.select_all("SELECT * FROM projects")
	erb :projects, :locals => { :title=> "Projects",:projects => projects }
end
