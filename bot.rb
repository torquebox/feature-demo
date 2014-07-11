topic = TorqueBox::Messaging::Topic.new('browser-messages')

topic.listen(selector: "sender is null") do |m|
  topic.publish("evilbot says: #{m} is dumb.",
                properties: {"sender" => "evilbot"})
end
