require 'torquebox-caching'

cache = TorqueBox::Caching.cache(:some_cache)

cache.put(:a_key, hi: "there")

puts cache.get(:a_key)

# TODO: something interesting
