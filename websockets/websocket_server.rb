require 'em-websocket'
require 'json'
require 'pry-rails'

EM.run do
  @clients = []
  @rooms = []
  @rooms_ids = []
  @users = []

  EM::WebSocket.start(host: '0.0.0.0', port: '3008') do |ws|
    ws.onopen do |handshake|
      params = CGI.parse(handshake.query_string)

      room = params["room"].first.to_i
      name = params["name"].first
      user_story = params["user_story"].first

      my_room_users = @clients.select { |client| client.instance_variable_get(:@room) == room }

      my_room_users.each do |client|
        if client.instance_variable_get(:@name) == name
          if (name[-1] =~ /[0-9]/).nil?
            name += "1"
          elsif name[-1] == "9"
            name[-1] = ""
            name += "10"
          elsif (name[-1] =~ /[0-9]/) == 0
            name[-1] = (name[-1].to_i + 1).to_s
          end
        end
      end

      ws.instance_variable_set(:@room, room)
      ws.instance_variable_set(:@name, name)
      ws.instance_variable_set(:@vote, "")

      @clients << ws

      unless @rooms_ids.include?(room) || params.nil?
        @rooms << { id: room, text: user_story }
        @rooms_ids << room
      end

      my_room = @rooms.detect { |r| r[:id] == room }

      my_room_users = @clients.select { |client| client.instance_variable_get(:@room) == room }

      my_room_users.each do |socket|
        my_room_users_names = my_room_users.map { |user|
          if user.signature == socket.signature || user.instance_variable_get(:@vote) == ""
            { name: user.instance_variable_get(:@name), vote: user.instance_variable_get(:@vote) }
          else
            { name: user.instance_variable_get(:@name), vote: "✓" }
          end
        }

        if socket.signature == ws.signature
          socket.send({ type: :room_status, message: my_room[:text], users: my_room_users_names, new_name: name }.to_json)
        else
          socket.send({ type: :users_list, users: my_room_users_names }.to_json)
        end
      end

      ws.send({ type: :info, message: "Poker room ready." }.to_json)
    end

    ws.onclose do
      @clients.delete ws

      my_room = ws.instance_variable_get(:@room)

      my_room_users = @clients.select { |client| client.instance_variable_get(:@room) == my_room }

      my_room_users.each do |socket|
        my_room_users_names = my_room_users.map { |user|
          if user.signature == socket.signature || user.instance_variable_get(:@vote) == ""
            { name: user.instance_variable_get(:@name), vote: user.instance_variable_get(:@vote) }
          else
            { name: user.instance_variable_get(:@name), vote: "✓" }
          end
        }

        if socket.signature == ws.signature
          socket.send({ type: :room_status, message: my_room[:text], users: my_room_users_names }.to_json)
        else
          socket.send({ type: :users_list, users: my_room_users_names }.to_json)
        end
      end
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
      end

      if message["type"] == "vote"
        @clients.each do |socket|
          if message["room"] == socket.instance_variable_get(:@room)
            if socket.instance_variable_get(:@name) == message["name"]
              socket.instance_variable_set(:@vote, message["text"])
              socket.send({ type: :update_vote, message: message["text"], name: message["name"] }.to_json)
            else
              socket.send({ type: :update_vote, message: "✓", name: message["name"] }.to_json)
            end

          end
        end
      end
    end
  end
end
