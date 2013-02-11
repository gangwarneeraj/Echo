#!/home/sdslabs/.rvm/rubies/ruby-1.9.2-p290/bin/ruby

$LOAD_PATH << "/home/sdslabs/EchoInstallations/Echo-Ruby/echo"
$LOAD_PATH << "/home/sdslabs/EchoInstallations/Echo-Ruby/echo/lib"

require 'thin'
require 'sinatra/contrib/all'
require 'rubygems'
require 'sinatra'
require 'json'
require 'viewHelper.rb'
require 'home.rb'
require 'result.rb'
require 'book.rb'
require 'recommend.rb'
require 'settings.rb'
require 'category.rb'
require 'category_search.rb'

ECHO_ROOT= File.join(File.expand_path(File.dirname(__FILE__)), '..') unless defined?(ECHO_ROOT)

#--Configuration ------------
configure do
    set :port, 4568
    set :public_folder, File.dirname(__FILE__) + "/public"
    set :root, File.dirname(__FILE__)
    set :app_file, __FILE__
    set :views, Proc.new {File.join(root, "views")}
    set :show_exceptions, true
    set :dump_errors, true
end

get '/' do
  HOME.view()
end



get '/category/?' do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
  category = params[:query]
  category.downcase!
  CATEGORY.getBookList(category)
  CATEGORY.getJSON()
end

get '/search/category/?' do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
  query = params[:query]
  query.downcase!
  CATEGORY_SEARCH.getCategoryResult(query)
  CATEGORY_SEARCH.getJSON()
end

get '/search/?' do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
  query = params[:query]
  query.downcase!
  puts query
  if query != ""
  RESULT.getEchoResult(query)
  RESULT.getJSON()
  end
end

get '/download/?' do 
  response['Access-Control-Allow-Origin'] = '*'
  id = params[:id]
  name = params[:name]
  send_file(SETTINGS.filePath + id, :filename => name)
end

get '/book/?' do
  response['Access-Control-Allow-Origin'] = '*'  
  id = params[:id]
  BOOK.getDetails(id)
  BOOK.getJSON()
end


get '/recommend/?' do
  response['Access-Control-Allow-Origin'] = '*'
  id = params[:id]
  RECOMMEND.getSimilarBooks(id)
  RECOMMEND.getJSON()
end


get '/homepage' do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
  RESULT.getEchoResult("string theory")
  res= RESULT.getJSON()
  rod = JSON.parse(res)
  rod[0].to_json

end
get '/about' do
  response['Access-Control-Allow-Origin'] = '*'
  ab= "Echo is an e-book content-search and recommendation engine. Fire away specific queries to let echo show you exactly what book you were looking for. All new! - You can now search for books with any set of keywords or name(s) of the author(s) or the ISBN "
end
