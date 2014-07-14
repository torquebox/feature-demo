topic = TorqueBox::Messaging.topic('browser-messages')

topic.listen(selector: "sender is null") do |m|
  topic.publish("evilbot says: #{m} is dumb.",
                properties: {"sender" => "evilbot"})
end
