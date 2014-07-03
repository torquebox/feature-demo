require 'sinatra'
require 'pp'

get '/' do
  [200,
   {'content-type' => 'text/plain'},
   request.pretty_inspect]
end

# require 'torquebox-web'
# TorqueBox::Web::Server.run('default', {root: '.'}).start
# Above is the same as: torquebox run
