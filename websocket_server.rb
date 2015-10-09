require 'thin'
require 'em-websocket'
require 'json'
require 'pry-rails'

EM.run do
  @clients = []

  EM::WebSocket.start(:host => '0.0.0.0', :port => '3008') do |ws|
    ws.onopen do |handshake|
      path = handshake.path
      path[0] = ""

      ws.instance_variable_set(:@room, path.to_i)
      @clients << ws

      ws.send "Poker room ready."
    end

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |msg|
      message = JSON.parse(msg)

      puts "Received Message: #{msg}"
      if message["type"] == 1
        @clients.each_with_index do |socket, index|
          if message["room"] == socket.instance_variable_get(:@room)
            socket.send message["text"]
          end

        end
      end
    end
  end

end
