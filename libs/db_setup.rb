#require "mysql"
#my = Mysql::new("host", "user", "passwd", "db")
#res = my.query("select * from tbl")
#res.each do |row|
#  col1 = row[0]
#  col2 = row[1]
#end
#require "mysql"
require "dbi"

begin
 # connect to the MySQL server
 $dbh = DBI.connect("DBI:Mysql:luume:localhost", "root", "root")
 # get server version string and display it
 row = $dbh.select_one("SELECT VERSION()")
 puts "Server version: " + row[0]
rescue DBI::DatabaseError => e
 puts "An error occurred"
 puts "Error code: #{e.err}"
 puts "Error message: #{e.errstr}"
ensure
 # disconnect from server
 #dbh.disconnect if dbh
end


