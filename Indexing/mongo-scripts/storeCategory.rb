# Code to store categories using n-gram. These grams will be
# used in category search.

require 'rubygems'
require 'mongo'

@connection = Mongo::Connection.new
@db = @connection.db('echo')
@coll = @db.collection('categoryList')
count = 0

Dir.foreach('/home/neeraj/Desktop/EchoTemp/Category') do |item|
next if item == '.' or item == '..'

begin
  count+=1
  puts count
  line = item.gsub('.txt', '')
  line.downcase!
  line.strip!
  line.split(" ").each do |substr|
      substr.strip!
      substr.downcase!
      s = substr.length()
      i = 3
      while(i <= s)
        j = 0
        while(j <= s - i)
          temp = substr[j, i]
          query = {"id" => temp}
          cursor = @coll.find(query)
          if cursor.next == nil
            @coll.insert(query)
          end
          @coll.update(query, {"$addToSet" => {"list" => line}})
          j = j +1
        end
        i = i + 1
     end
  end
rescue Exception => msg
  puts "Something is wrong"+msg
end
end
