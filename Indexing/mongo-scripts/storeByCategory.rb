# Code to store books according to category

require 'rubygems'
require 'mongo'

@connection = Mongo::Connection.new
@db = @connection.db('echo')
@coll = @db.collection('categories')

Dir.foreach('/home/neeraj/Desktop/EchoTemp/Category') do |item|
  next if item == '.' or item == '..'
  path = '/home/neeraj/Desktop/EchoTemp/Category/' + item
  file = File.open(path, 'r')
  cat = item.gsub!('.txt', '').downcase!
  query = {'id'=> cat}
  cursor = @coll.find(query)
  if !cursor.has_next?
     @coll.insert(query)
  end
  while(line = file.gets)
    line.strip!
    @coll.update(query, {'$addToSet' => {'list' => line}})
  end
end
