//= require app.js

angular.module('ppApp').controller("PokerRoomController", [
    '$scope', '$timeout', 'PokerRoomService',

    function($scope, $timeout, PokerRoomService){

        var location = window.location.pathname.split('/');
        var id = location.pop();

        console.log(id);
        var socket, host;
        host = "ws://localhost:3008/"+id;

        $scope.userStory = "";

        function connect() {
            try {
                socket = new WebSocket(host);

                socket.onopen = function() {
                    addMessage("Connection Status: OPEN");
                };

                socket.onclose = function() {
                    addMessage("Connection Status: CLOSED");
                };

                socket.onmessage = function(msg) {
                    updateUserStory(msg.data);
                }
            } catch(exception) {
                addMessage("Error: " + exception);
            }


        }

        function addMessage(msg) {
            $("#chat-log").append("<p>" + msg + "</p>");
        }

        function updateUserStory(msg){
            $scope.$apply(function () {
               $scope.userStory = msg;
            });
        }

        $scope.sendMessage = function(){

            var message = {
                type: 1,
                text: $scope.userStory,
                room: $scope.poker_room.id
            };

            message = JSON.stringify(message);

            if(message.text == '') {
                addMessage("Please Enter a Message");
                return;
            }

            try {
                socket.send(message);
            } catch(exception) {
                addMessage("Failed To Send");
            }

        };

        $('#message').keypress(function(event) {
            if (event.keyCode == '13') { $scope.sendMessage(); }
        });

        $("#disconnect").click(function() {
            socket.close()
        });

        function init(){
            PokerRoomService.getPokerRoomAction(id);
            connect();
        }

        init();
    }
]);