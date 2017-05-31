//= require app.js

angular.module('ppApp').service("NameService", function($http, $rootScope){

    this.setName = function(data){
      return $http.post('session.json', data);
    };

    this.setNameAction = function(data){
        this.setName(data).then(function(successResponse){
                console.log(successResponse.data);
            },
            function(errorResponse){
                console.log("error");
            });
    }

});