'use strict';

/**
 * Controller for showing a user's profile page
 */
angular.module('microblogApp')
  .controller('UserCtrl', ['$scope', '$http', '$routeParams', 'ConfigService',
    function ($scope, $http, $routeParams, ConfigService) {

      var getUserData = function() {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'users/' + $routeParams.id,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
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

