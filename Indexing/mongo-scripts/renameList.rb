# Code to get Map of UUIDs and Local File Name from DB.

require 'rubygems'
require 'mongo'

db = Mongo::Connection.new.db("echo")
coll = db.collection("books")
cursor = coll.find()
file = File.open('name_uuid.txt','w')
f = File.open('name_uuid_error.txt','w')
count = 0
while cursor.has_next?
  doc = cursor.next
  if doc['localFileName'] != nil
    file.puts(doc['uuid'] +' ' + doc['localFileName'])
  else
    f.puts(doc['uuid'] + ' ' + doc['localFileName'])
    count += 1
  end
end
file.close
puts count

