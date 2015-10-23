//= require app.js

angular.module('ppApp').filter('reverse', function() {
    return function(items) {
        if (!angular.isArray(items)) return false;
        return items.slice().reverse();
    };
});