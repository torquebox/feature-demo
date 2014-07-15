require 'torquebox-caching'

cache = TorqueBox::Caching.cache(:some_cache)

# caches act like hashes, and supports the expected operations:
cache[:a_key] = [1, 2, 3]

puts cache[:a_key].inspect

# they are also java.util.concurrent.ConcurrentMaps, so support atomic
# operations

# #put_if_absent only sets the value if it doesn't exist, returning the
# current value, or nil if no action taken
cache.put_if_absent(:another_key, 1) # => nil
cache.put_if_absent(:another_key, 2) # => 1, cache is unchanged

# #replace only sets the value if the key already exists in the cache,
# returning the previous value, or nil if no action taken
cache.replace(:another_key, :hi)    # =>  2
cache.replace(:foobar, :hi)         # => nil

# #compare_and_set only sets the value if the key already exists in the
# cache *with the given old value*. Returns true if the replace
# worked.
cache.compare_and_set(:another_key, :hi, :new_value)     # => true
cache.compare_and_set(:another_key, :hi, :another_value) # => false

# #remove works like #compare_and_set, and only removes the entry if
# it's key *and value* match the given params. Returns true if the
# entry was removed.
cache.remove(:another_key, :some_value) # => true
cache.remove(:another_key, :new_value)  # => true

# caches also support :ttl and :idle options. They can be passed to
# any of the atomic operations above, as well as #put

# this entry will disappear after 1 second
cache.put(:a_key, :a_value, ttl: 1000)

# this entry will disappear 1 second after being last accessed. Any
# access during that second resets the counter
cache.put(:a_key, :a_value, idle: 1000)

# caches encode keys and values. The encoding is set when looking up
# the cache
another_cache = TorqueBox::Caching.cache(:another, encoding: :json)

# valid encodings are: :edn, :json, :marshal, :marshal_base64,
# :marshal_smart. The first two require an edn or json gem to be
# available, respectively.

# caches are replicated across nodes in a cluster by default.

# an example to demonstrate two nodes sharing a cache in a cluster
require 'torquebox-scheduling'

shared_cache = TorqueBox::Caching.cache(:shared_cache)

# try to compare and set the count value on each node once per second
# with two nodes, we should see one node setting odd values, the other
# even
TorqueBox::Scheduling::Scheduler.schedule(:count_updater,
                                          every: 1000,
                                          singleton: false) do
  value = shared_cache.put_if_absent(:count, 0)
  if value.nil?
    puts "initialized count with 0"
  else
    result = shared_cache.compare_and_set(:count, value, value + 1)
    puts "updating :count from #{value} to #{value + 1}: #{result ? 'success' : 'FAILURE'}"
  end
end
