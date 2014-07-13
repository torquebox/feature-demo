require 'torquebox-scheduling'

# schedule a job with a name and options
job = TorqueBox::Scheduling::Scheduler.schedule(:foo, every: 1000) do
  puts "called every second"
end

# stop the job
job.unschedule

# or stop it by name
TorqueBox::Scheduling::Scheduler.unschedule(:foo)

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
