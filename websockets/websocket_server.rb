require 'em-websocket'
require 'json'
require 'pry-rails'

EM.run do
  @clients = []
  @rooms = []
  @rooms_ids = []

  EM::WebSocket.start(host: '0.0.0.0', port: '3008') do |ws|
    ws.onopen do |handshake|
      path = handshake.path
      path[0] = ""

      ws.instance_variable_set(:@room, path.to_i)
      @clients << ws

      ws.send({ type: :info, message: "Poker room ready." }.to_json)
    end

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |msg|
      message = JSON.parse(msg)

      puts "Received Message: #{msg}"
      if message["type"] == "user_story"

        @rooms.map! { |room| (room[:id] == message["room"]) ? { id: room[:id], text: message["text"] } : room }

        @clients.each do |socket|
          if message["room"] == socket.instance_variable_get(:@room)
            socket.send({ type: :update_story, message: message["text"] }.to_json)
          end
        end

      elsif message["type"] == "poker_room"
        unless @rooms_ids.include?(message["room"].to_i) || message["room"].nil?
          @rooms << { id: message["room"].to_i, text: message["text"] }
          @rooms_ids << message["room"].to_i
        end

        my_room = @rooms.detect { |room| room[:id] == message["room"].to_i }

        ws.send({ type: :update_story, message: my_room[:text] }.to_json)
      end
    end
  end
end
