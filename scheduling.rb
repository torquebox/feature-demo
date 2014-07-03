require 'torquebox-scheduling'

TorqueBox::Scheduling::Scheduler.schedule(:foo, in: 500) do
  puts "called"
end

job = TorqueBox::Scheduling::Scheduler.schedule(:foo, every: 1000) do
  puts "called every second"
end

job.unschedule

# activesupport Numeric muckery supported

require 'active_support/all'

TorqueBox::Scheduling::Scheduler.schedule(:foo, every: 1.second, in: 5.seconds, limit: 3) do
  puts "called every second, thrice, starting in 5 seconds"
end
