require 'torquebox-web'
require 'torquebox-messaging'

topic = TorqueBox::Messaging::Topic.new('browser-messages')

TorqueBox::Web::Server.sockjs('/messages').on_connection do |conn|
  listener = topic.listen do |m|
    conn.write(m)
  end

  conn.on_data do |data|
    topic.publish(data)
  end

  conn.on_close do
    listener.close
  end

  topic.publish("Welcome!")
end
