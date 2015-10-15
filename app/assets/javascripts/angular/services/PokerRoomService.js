//= require app.js

angular.module('ppApp').service('PokerRoomService', function($http, $rootScope){

    this.getPokerRoom = function(id) {
        return $http.get('poker_rooms/' + id + '.json');
    };

    this.getPokerRoomAction = function(id){
        this.getPokerRoom(id).then(function(successResponse){
            $rootScope.poker_room = successResponse.data;
            $rootScope.userStory = successResponse.data.user_story;
        },
        function(errorResponse){
            console.log("Error");
        });
    };
});