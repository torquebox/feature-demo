require 'torquebox-caching'

cache = TorqueBox::Caching.cache(:some_cache)

cache.put(:a_key, [1, 2, 3])

puts cache.get(:a_key)

# TODO: something interesting
