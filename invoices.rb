post '/invoices' do
	$dbh.do("INSERT INTO invoices(name) VALUES(?)",params[:name]) if !params[:name].nil? && params[:name].length > 0 
	redirect '/invoices'
end

get '/invoices/delete/:id' do
	$dbh.do("DELETE FROM invoices WHERE invoice_id=?",params[:id]) if /^\d+$/ =~ params[:id]
	redirect '/invoices'
end

get '/invoices' do
	invoices = $dbh.select_all("SELECT * FROM invoices")
	erb :invoices, :locals => { :title=> "Invoices",:invoices => invoices }
end
