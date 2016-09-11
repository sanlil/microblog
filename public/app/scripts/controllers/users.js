'use strict';

/**
 * Controller for listing all users
 */
angular.module('microblogApp')
  .controller('UsersCtrl', ['$scope', '$http', 'ConfigService',
    function ($scope, $http, ConfigService) {

      var getAllUsers = function() {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'users',
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log('success');
          console.log(data);
          $scope.users = data.users;
        })
        .error(function(data) {
          console.log('error');
          console.log(data);
        });
      };

      getAllUsers();

    }
    
  ]);

