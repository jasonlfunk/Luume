#require "mysql"
#my = Mysql::new("host", "user", "passwd", "db")
#res = my.query("select * from tbl")
#res.each do |row|
#  col1 = row[0]
#  col2 = row[1]
#end
#require "mysql"
require "rubygems"
require "dbi"

begin
 # connect to the MySQL server
 # $dbh = DBI.connect("DBI:Mysql:Luume:localhost", "funkju", "5dogma")
 $dbh = DBI.connect("DBI:Mysql:database=Luume;host=localhost;socketApplications/MAMP/tmp/mysql/mysql.sock", "funkju", "5dogma")
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


