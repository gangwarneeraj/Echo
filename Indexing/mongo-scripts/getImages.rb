# Code to download images from google and store them.
# Name of images: UUIDs

require 'fileutils'
require 'open-uri'

file = File.new('data.txt','r')
counter = 0
while (line = file.gets)
counter += 1
puts 'done'
s = line.size
i = line.index(' ')
id = line[0,i]
url = line[i+1,s]
#FileUtils.cp '/home/neeraj/Desktop/images.jpg', '/home/neeraj/Desktop/Final Echo Files/images/'+id 
open('/home/neeraj/Desktop/EchoTemp/images/'+id, 'wb') do |temp|
	temp << open(url).read
end
puts counter
puts line
end
