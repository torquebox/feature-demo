require 'torquebox-scheduling'

scheduler = TorqueBox::Scheduling::Scheduler

scheduler.schedule(:foo, in: 500) do
  puts "called"
end

job = scheduler.schedule(:foo, every: 1000) do
  puts "called every second"
end

job.unschedule

# activesupport Numeric muckery supported

require 'active_support/all'

scheduler.schedule(:foo,
                   every: 1.second,
                   in: 5.seconds,
                   limit: 3) do
  puts "called every second, thrice, starting in 5 seconds"
end

# other options?
# cron spec?
# singleton?
