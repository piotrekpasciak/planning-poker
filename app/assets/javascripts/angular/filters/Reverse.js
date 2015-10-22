//= require app.js

angular.module('ppApp').filter('reverse', function() {
    return function(items) {
        return items.slice().reverse();
    };
});