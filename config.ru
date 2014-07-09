require 'rubygems'
require 'web'

run Sinatra::Application

require 'sockjs'
require 'messaging'
require 'scheduling'
require 'caching'
