module WebsocketUtility
  class WebsocketData
    def self.room(rooms, id)
      rooms.detect { |r| r[:id] == id }
    end

    def self.room_users(clients, room)
      clients.select { |client| client.instance_variable_get(:@room) == room }
    end

    def self.room_users_list_hidden(room_users, current_user)
      room_users.map do |user|
        if user.signature == current_user.signature || user.instance_variable_get(:@vote) == ""
          { name: user.instance_variable_get(:@name), vote: user.instance_variable_get(:@vote) }
        else
          { name: user.instance_variable_get(:@name), vote: "✓" }
        end
      end
    end

    def self.room_users_list_shown(room_users)
      room_users.map { |user| { name: user.instance_variable_get(:@name), vote: user.instance_variable_get(:@vote) } }
    end
  end

  class RenameUser
    def self.rename_user(clients, room, name)
      users = WebsocketData.room_users(clients, room)

      users.each do |client|
        next unless client.instance_variable_get(:@name) == name

        if (name[-1] =~ /[0-9]/).nil?
          name += "1"
        elsif name[-1] == "9"
          name[-1] = ""
          name += "10"
        elsif (name[-1] =~ /[0-9]/) == 0
          name[-1] = (name[-1].to_i + 1).to_s
        end
      end
      name
    end
  end
end
