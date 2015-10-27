//= require app.js

angular.module("ppApp").directive('overlay', function($rootScope){
    return{
        restrict: 'E',
        templateUrl: 'overlay.html',
        link: function(scope, element, attrs){
            scope.visible = false;

            $rootScope.$on("overlay-show", function (event) {
                scope.visible = true;
            });

            $rootScope.$on("overlay-hide", function (event) {
                scope.visible = false;
            })
        }
    };
});