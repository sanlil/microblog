'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('MainCtrl', function ($scope, $http, $location, ConfigService) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.logout = function() {
        console.log('CLICK LOGOUT!');

        $http({
            method: 'DELETE',
            url: ConfigService.apiUrl() + 'logout',
            headers: { 'Content-Type': 'application/json',  }
          })
          .success(function (data, status, headers, config) {
            console.log('data:', data);
            console.log('status:', status);
            $location.path('/');
            
          })
          .error(function (data, status, headers, config) {
            console.log( 'failure message: ' + JSON.stringify({data: data}));
            console.log('data:', data);
            console.log('status:', status);
          });
      };


  });
