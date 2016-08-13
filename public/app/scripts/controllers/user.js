'use strict';

/**
 * Controller for showing a user's profile page
 */
angular.module('microblogApp')
  .controller('UserCtrl', ['$scope', '$http', '$routeParams', 'ConfigService',
    function ($scope, $http, $routeParams, ConfigService) {

      var getUserData = function() {
        $http.get(ConfigService.apiUrl() + 'users/' + $routeParams.id)
          .success(function(data) {
            console.log('success');
            console.log(data);
            $scope.user = data.user;
          })
          .error(function(data) {
            console.log('error');
            console.log(data);
          });
      };

      getUserData();

    }
    
  ]);

