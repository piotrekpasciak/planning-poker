//= require app.js

angular.module('ppApp').controller("PokerRoomController", [
    '$scope', 'PokerRoomService',

    function($scope, PokerRoomService){

        var location = window.location.pathname.split('/');
        var id = location.pop();

        function init(){
            PokerRoomService.getPokerRoomAction(id);
        }

        init();
    }
]);