require 'em-websocket'
require 'json'
require 'pry-rails'
require_relative 'websocket_utility'

include WebsocketUtility

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

      name = RenameUser.rename_user(@clients, room, name)

      ws.instance_variable_set(:@room, room)
      ws.instance_variable_set(:@name, name)
      ws.instance_variable_set(:@vote, "")

      @clients << ws

      if @rooms_ids.include?(room)
        @rooms.map! { |r| (r[:id] == ws.instance_variable_get(:@room)) ? { id: r[:id], text: r[:text], status: "hidden_votes" } : r }
      else
        @rooms << { id: room, text: user_story, status: "hidden_votes" }
        @rooms_ids << room
      end

      my_room = WebsocketData.room(@rooms, room)
      my_room_users = WebsocketData.room_users(@clients, room)

      my_room_users.each do |user|
        my_room_users_list = WebsocketData.room_users_list_hidden(my_room_users, user)

        if user.signature == ws.signature
          user.send({ type: :room_status, message: my_room[:text], users: my_room_users_list, new_name: name }.to_json)
        else
          user.send({ type: :users_list, users: my_room_users_list }.to_json)
        end
      end

      ws.send({ type: :info, message: "Poker room ready." }.to_json)
    end

    ws.onclose do
      @clients.delete ws

      my_room = WebsocketData.room(@rooms, ws.instance_variable_get(:@room))
      my_room_users = WebsocketData.room_users(@clients, my_room[:id])

      if my_room[:status] == "hidden_votes"
        my_room_users.each do |user|
          my_room_users_names = WebsocketData.room_users_list_hidden(my_room_users, user)

          if user.signature == ws.signature
            user.send({ type: :room_status, message: my_room[:text], users: my_room_users_names }.to_json)
          else
            user.send({ type: :users_list, users: my_room_users_names }.to_json)
          end
        end
      elsif my_room[:status] == "shown_votes"
        my_room_users_names = WebsocketData.room_users_list_shown(my_room_users)

        my_room_users.each do |socket|
          if socket.signature == ws.signature
            socket.send({ type: :room_status, message: my_room[:text], users: my_room_users_names }.to_json)
          else
            socket.send({ type: :users_list, users: my_room_users_names }.to_json)
          end
        end
      end
    end

    ws.onmessage do |msg|
      message = JSON.parse(msg)

      puts "Received Message: #{msg}"

      if message["type"] == "user_story" && message["text"] != "" && !message["text"].nil?
        @rooms.map! { |room| (room[:id] == message["room"]) ? { id: room[:id], text: message["text"], status: room[:status] } : room }

        @clients.each do |socket|
          if message["room"] == socket.instance_variable_get(:@room)
            socket.send({ type: :update_story, message: message["text"] }.to_json)
          end
        end
      elsif message["type"] == "vote"
        my_room = WebsocketData.room(@rooms, ws.instance_variable_get(:@room))
        my_room_users = WebsocketData.room_users(@clients, my_room[:id])

        if my_room[:status] == "hidden_votes"
          my_room_users.each do |socket|
            next unless message["room"] == socket.instance_variable_get(:@room)

            if socket.instance_variable_get(:@name) == message["name"]
              socket.instance_variable_set(:@vote, message["text"])
              socket.send({ type: :update_vote, message: message["text"], name: message["name"] }.to_json)
            else
              socket.send({ type: :update_vote, message: "✓", name: message["name"] }.to_json)
            end
          end
        elsif my_room[:status] == "shown_votes"
          my_room_users.each do |socket|
            if socket.instance_variable_get(:@name) == message["name"]
              socket.instance_variable_set(:@vote, message["text"])
            end
            socket.send({ type: :update_vote, message: message["text"], name: message["name"] }.to_json)
          end
        end
      elsif message["type"] == "show_votes"
        @rooms.map! { |room| (room[:id] == ws.instance_variable_get(:@room)) ? { id: room[:id], text: room[:text], status: "shown_votes" } : room }

        my_room_users = WebsocketData.room_users(@clients, ws.instance_variable_get(:@room))

        my_room_users_names = my_room_users.map { |user| {  name: user.instance_variable_get(:@name), vote: user.instance_variable_get(:@vote) } }

        my_room_users.each do |socket|
          socket.send({ type: :users_list, users: my_room_users_names }.to_json)
        end
      elsif message["type"] == "clear_votes" && message["text"] != "" && !message["text"].nil?
        @rooms.map! { |room| (room[:id] == ws.instance_variable_get(:@room)) ? { id: room[:id], text: room[:text], status: "hidden_votes" } : room }

        my_room_users = WebsocketData.room_users(@clients, ws.instance_variable_get(:@room))
        my_room_users_names = WebsocketData.room_users_list_shown(my_room_users)

        my_room_users.each do |user|
          user.send({ type: :summary, message: my_room_users_names, owner: ws == user }.to_json)
          user.instance_variable_set(:@vote, "")
        end

        my_room_users_names = WebsocketData.room_users_list_shown(my_room_users)

        my_room_users.each do |socket|
          socket.send({ type: :users_list, users: my_room_users_names }.to_json)
        end
      end
    end
  end
end
