'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('MainCtrl', function ($scope, $rootScope, $http, $location, $cookieStore, ConfigService, CurrentUserService) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.isLoggedIn = false;

    var setCurrentUser = function() {
      if (!CurrentUserService.getUser()) {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'user',
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log('success');
          console.log(data);
          CurrentUserService.setUser(data.user);
          console.log('current user is: ', CurrentUserService.getUser());
        })
        .error(function(data) {
          console.log('error');
          console.log(data);
        });
      }
    };
    setCurrentUser();

    $scope.logout = function() {
      console.log('CLICK LOGOUT!');

      $http({
        method: 'DELETE',
        url: ConfigService.apiUrl() + 'logout',
        headers: {
          'Authorization': ConfigService.getToken()
        }
      })
      .success(function (data, status, headers, config) {
        console.log('data:', data);
        console.log('status:', status);
        $cookieStore.remove('auth_token');
        CurrentUserService.clearUser();
        $location.path('/');
      })
      .error(function (data, status, headers, config) {
        console.log( 'failure message: ' + JSON.stringify({data: data}));
        console.log('data:', data);
        console.log('status:', status);
      });
    };

    $rootScope.$on('user-updated', function() {
      console.log('nav broadcast user-updated, username: ' + CurrentUserService.getName());
      $scope.isLoggedIn = (CurrentUserService.getUser() !== null);
      $scope.username = CurrentUserService.getName();
      $scope.userImg = CurrentUserService.getPicture();
      $scope.userId = CurrentUserService.getId();
    });

    $scope.goToProfile = function() {
      $location.path('/users/' + CurrentUserService.getId());
    };

  });
