require 'torquebox-messaging'

# create a reference to a queue. will create the queue in HornetQ as
# well if it doesn't already exist
queue = TorqueBox::Messaging::Queue.new('some-queue')

# attach a listener to the queue that will be called when a message
# comes in
queue.listen do |m|
  puts "Listener received #{m}"
end

# send ten messages to the queue
10.times do |n|
  queue.publish({message: n})
end

# default encoding is marshal
puts TorqueBox::Messaging.default_encoding

# show json, edn also supported (if gems are loaded)

# you can override the default
# TorqueBox::Messaging.default_encoding = :json

# request/respond

sync_queue = TorqueBox::Messaging::Queue.new('sync-queue')

# attach a responder - a listener who's return value is sent to the
# requester
sync_queue.respond do |m|
  puts "Responder received #{m}"
  sleep(2)
  m.upcase
end

# send requests - each will block waiting for the response
%w{foo bar ham biscuit}.map do |m|
  response = sync_queue.request(m)
  puts "Response is #{response}"
  response
end

# can connect to a remote HornetQ
# can talk to apps in other languages (clojure, java, etc)
