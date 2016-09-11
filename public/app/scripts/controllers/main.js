'use strict';

/**
 * Main controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('MainCtrl', function ($scope, $rootScope, $http, $location, $cookieStore, ConfigService, CurrentUserService) {

    $scope.isLoggedIn = false;

    var setCurrentUser = function() {
      if (!CurrentUserService.getUser() && ConfigService.getToken()) {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'user',
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          CurrentUserService.setUser(data.user);
          console.log('current user is: ', CurrentUserService.getUser());
          $scope.isLoggedIn = true;
        })
        .error(function(data) {
          console.log('Unsuccessful get user:', data);
          $scope.isLoggedIn = false;
        });
      }
    };
    setCurrentUser();

    $scope.logout = function() {
      $http({
        method: 'DELETE',
        url: ConfigService.apiUrl() + 'logout',
        headers: {
          'Authorization': ConfigService.getToken()
        }
      })
      .success(function (data) {
        console.log('Logout response:', data);
        $cookieStore.remove('auth_token');
        CurrentUserService.clearUser();
        $location.path('/');
      })
      .error(function (data) {
        console.log('Unsuccessful logout:', data);
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
