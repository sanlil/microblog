'use strict';

/**
 * Controller for showing a user's profile page
 */
angular.module('microblogApp')
  .controller('UserCtrl', ['$scope', '$http', '$routeParams', 'ConfigService', 'CurrentUserService',
    function ($scope, $http, $routeParams, ConfigService, CurrentUserService) {

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
          $scope.microposts = data.user.microposts;
        })
        .error(function(data) {
          console.log('error');
          console.log(data);
        });
      };

      getUserData();

    }
    
  ]);

