//= require app.js

angular.module('ppApp').controller("HomeController", [
    '$scope', 'PokerRoomService',

    function($scope, PokerRoomService){

        $scope.createPokerRoom = function(data){
            PokerRoomService.createPokerRoomAction(data);
        };

        function init(){

        }

        init();
    }
]);