//= require app.js

angular.module('ppApp').service('SummaryService', function($http, $rootScope){

    this.getSummaries = function(id) {
      return $http.get('poker_rooms/' + id + '/summaries.json');
    };

    this.createSummary = function(id, data) {
        return $http.post('poker_rooms/' + id + '/summaries.json', data);
    };

});