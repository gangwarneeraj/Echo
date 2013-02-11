require 'json'
require 'mongo'
require 'singleton'
load 'settings.rb'
require 'haml'
load 'book.rb'
load 'viewHelper.rb' 

class PickOfTheDay
	include Singleton
def initialize()
    @view = ViewHelper.new()
    @db = Mongo::Connection.new(SETTINGS.getMongoIP, SETTINGS.getMongoPort).db('echo')
    
  end                                
 
def printRandomNumber()
@book = db.collection('books')
count= @book.count()
randno = Random.rand(count)
potd = Hash.new
potd = @book.find({ :skip => randno })
p potd

end

end



