'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('MainCtrl', function ($scope, $rootScope, $http, $location, ConfigService, CurrentUserService) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.isLoggedIn = false;

    var checkCurrentUser = function() {
      console.log('current user is: ', CurrentUserService.getUser(), (CurrentUserService.getUser()===null));
      // Should get user data from API
    };
    checkCurrentUser();

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

    $rootScope.$on('login-done', function() {
      console.log('nav broadcast login-done, username: ' + CurrentUserService.getName());
      $scope.isLoggedIn = true;
      $scope.username = CurrentUserService.getName();
      $scope.userImg = CurrentUserService.getPicture();
      $scope.userId = CurrentUserService.getId();
    });

    $scope.goToProfile = function() {
      $location.path('/users/' + CurrentUserService.getId());
    };

  });
