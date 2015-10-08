//= require app.js

angular.module('ppApp').service('PokerRoomService', function($http, $rootScope){

    this.getPokerRoom = function(id) {
        return $http.get('poker_rooms/' + id + '.json');
    };

    this.createPokerRoom = function(data) {
        return $http.post('poker_rooms.json', data)
    };

    this.getPokerRoomAction = function(id){
        this.getPokerRoom(id).then(function(successResponse){
            $rootScope.poker_room = successResponse.data;
        },
        function(errorResponse){
            console.log("Error");
        });
    };

    this.createPokerRoomAction = function(data) {
        this.createPokerRoom(data).then(function(successResponse){
            document.location.href='poker_rooms/' + successResponse.data.id;
        },
        function(errorResponse){
            console.log("Error");
        });
    };
});