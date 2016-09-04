'use strict';

angular.module('microblogApp')
  .controller('CreateCtrl', function ($scope, $http, $location, ConfigService, CurrentUserService) {

    console.log('create ctrl');

    $scope.post = function() {
      if ($scope.micropost.length > 0) {
        $http({
          method: 'POST',
          url: ConfigService.apiUrl() + 'microposts',
          data: {'micropost': {'content': $scope.micropost}},
          headers: {
            'Content-Type': 'application/json',
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function (data, status, headers, config) {
          console.log('POST CREATED!');
          console.log('data:', data);
          console.log('status:', status);
          $scope.micropost = '';
          $location.path('/users/' + CurrentUserService.getId());
        })
        .error(function (data, status, headers, config) {
          console.log( 'failure message: ' + JSON.stringify({data: data}));
          console.log('data:', data);
          console.log('status:', status);
          $scope.errors = data;
        });
      } else {
        console.log('Error! No content!');
      }
    };

  });