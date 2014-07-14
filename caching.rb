require 'torquebox-caching'

cache = TorqueBox::Caching.cache(:some_cache)

cache.put(:a_key, [1, 2, 3])

puts cache.get(:a_key).inspect

# TODO: something interesting


# an example to demonstrate two nodes sharing a cache in a cluster
require 'torquebox-scheduling'

shared_cache = TorqueBox::Caching.cache(:shared_cache)

# try to compare and set the count value on each node once per second
# with two nodes, we should see one node setting odd values, the other
# even
TorqueBox::Scheduling::Scheduler.schedule(:count_updater,
                                          every: 1000,
                                          singleton: false) do
  if shared_cache.contains_key?(:count)
    value = shared_cache.get(:count)
    result = shared_cache.compare_and_set(:count, value, value + 1)
    puts "updating :count from #{value} to #{value + 1}: #{result ? 'success' : 'FAILURE'}"
  else
    puts "initializing count with 0"
    shared_cache.put(:count, 0)
  end
end
