require 'torquebox-messaging'

queue = TorqueBox::Messaging::Queue.new('some-queue')

queue.listen do |m|
  puts "Listener received #{m}"
end

10.times do |n|
  queue.publish(message: n)
end

# encodings
# show json (only works because json gem is available)
# show default

# request/respond

sync_queue = TorqueBox::Messaging::Queue.new('sync-queue')

sync_queue.respond do |m|
  puts "Responder received #{m}"
  sleep(2)
  m.upcase
end

%w{foo bar ham biscuit}.map do |m|
  response = sync_queue.request(m)
  puts "Response is #{response}"
  response
end

# can connect to a remote HornetQ
# can talk to apps in Clojure (via Immutant)
