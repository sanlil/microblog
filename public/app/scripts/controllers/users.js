'use strict';

/**
 * Controller for listing all users
 */
angular.module('microblogApp')
  .controller('UsersCtrl', ['$scope', '$http', '$location', 'ConfigService',
    function ($scope, $http, $location, ConfigService) {

      var getAllUsers = function() {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'users',
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log('get all users response:', data);
          $scope.users = data.users;
        })
        .error(function(data) {
          console.log('could not get all users:', data);
        });
      };
      getAllUsers();

      $scope.goToUser = function(userId) {
        console.log('location: '+'users/' + userId);
        $location.path('users/' + userId);
      };

    }
    
  ]);

