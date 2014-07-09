#!/bin/env jruby

require 'torquebox-messaging'

type, destination_name = ARGV.shift.split(':')
message = ARGV.join(' ')

puts "Sending '#{message}' to #{type} #{destination_name}"

TorqueBox::Messaging::Connection.new(host: 'localhost', port: 5445) do |connection|
  destination = (type == 'queue' ?
                 TorqueBox::Messaging::Queue :
                 TorqueBox::Messaging::Topic).new(destination_name,
                                                  connection: connection)
  destination.publish(message)
end
