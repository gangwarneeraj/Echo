# Code to store book info in DB

require 'rubygems'
require 'json'
require 'mongo'

@db = Mongo::Connection.new.db("echo")

file = File.new("newInfo.txt", "r")
counter = 0
result = []
while( line = file.gets)
  puts line.strip!
  h = Hash.new
  line.split("\",\"").each do  |entry| 

    if(entry.split(" : ")[0].gsub("\"", "") == 'mainCategory')
      h2 = Array.new
      entry.split(" : ")[1].gsub("\"", "").split("\/").each do |e|
	e.gsub!("\\", "")
	e.strip!
        h2 << e
      end
      h[entry.split(" : ")[0].gsub("\"", "")] = h2
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'categories')
      val =  entry.split(" : ")[1].gsub!("\"", "")
      val.gsub!("[", "")
      val.gsub!("]", "")
      val.gsub!("\\\/", "")
      val.gsub!("\\", "")
      h2 = Array.new
      val.split(",").each do |a|
        h2 << a
      end
      h[entry.split(" : ")[0].gsub("\"", "")] = h2 
    elsif(entry.split(" : ")[0].gsub("\"", "") == 'authors')
      val =  entry.split(" : ")[1].gsub("\"", "").gsub("[", "").gsub("]", "").gsub("\\", "")
      h['authors'] = val
    elsif(entry.split(" : ")[0].gsub("\"","") == 'localFileName')
      val = entry.split("\" : \"")[1].gsub("\"", "").gsub("\\", "").gsub("}", "")
      h['localFileName'] = val
    else
      
      val =entry.split(" : ")[0]
       val.gsub!("\"", "")
      val.gsub!("{","")
      val1=entry.split(" : ")[1]
      val1.gsub!("\"", "")
      val1.gsub!("}","")
      val.strip!
      h[val] =val1 
    end
  end
  counter = counter + 1
  result << h
  puts h
end

file.close
puts counter

@coll = @db.collection("books")

result.each do |entry|
  @coll.insert(entry)    
end
