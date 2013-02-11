# config.ru
$: << File.expand_path(File.dirname(__FILE__))

require 'echo.rb'
run Sinatra::Application

