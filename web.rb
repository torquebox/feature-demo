require 'sinatra'
require 'pp'

get '/' do
  [200,
   {'content-type' => 'text/plain'},
   request.pretty_inspect]
end

# require 'torquebox-web'
# TorqueBox::Web.run(root: '.', rackup: 'basic.ru')
#
# Above is what happens when you:
# - `rackup -s torquebox`
# - `rails server torquebox`
# - `torquebox run`
