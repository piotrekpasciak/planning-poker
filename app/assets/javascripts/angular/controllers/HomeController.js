//= require app.js

angular.module('ppApp').controller("HomeController", [
    '$scope',

    function($scope){

        $scope.test = "Poker to rule them all";
        function init(){

        }

        init();
    }
]);