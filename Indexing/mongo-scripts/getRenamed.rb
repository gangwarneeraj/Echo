# Code to rename book name to UUIDs

require 'fileutils'
require 'open-uri'

file = File.new('name_uuid.txt','r')
counter = 0
while (line = file.gets)
s = line.size
i = line.index(' ')
id = line[0,i]
localName = line[i+1,s]
localFile = localName.strip
if File.exists?(localFile) 
	FileUtils.cp localFile, '/home/neeraj/Desktop/Final Echo Files/Books/'+id 
	puts 'done'
	counter += 1
end

puts counter
end
