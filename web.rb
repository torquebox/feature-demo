require 'sinatra'
require 'pp'

get '/' do
  [200,
   {'content-type' => 'text/plain'},
   request.pretty_inspect]
end

# require 'torquebox-web'
# TorqueBox::Web::Server.run('default', {root: '.', rackup: 'basic.ru'}).start
# Above is similar to: `rackup -s torquebox` or `rails server -s torquebox`
