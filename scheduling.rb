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

TorqueBox::Scheduling::Scheduler.schedule(:foo,
                                          every: 1.second,
                                          in: 5.seconds,
                                          limit: 3) do
  puts "called every second, thrice, starting in 5 seconds"
end

# These jobs demonstrate singleton behavior in a cluster

TorqueBox::Scheduling::Scheduler.schedule(:a_singleton,
                                          every: 5.seconds) do
  puts "I should only run on one node"
end

TorqueBox::Scheduling::Scheduler.schedule(:a_non_singleton,
                                          every: 5.seconds,
                                          singleton: false) do
  puts "I should run on every node"
end
