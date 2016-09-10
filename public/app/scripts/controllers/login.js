'use strict';

/**
 * Login controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('LoginCtrl', ['$scope', '$http', '$location', '$cookieStore', 'ConfigService', 'CurrentUserService',
    function ($scope, $http, $location, $cookieStore, ConfigService, CurrentUserService) {
      
      $scope.email = '';
      $scope.password = '';
      $scope.loginError = '';
      $scope.signupErrors = [];

      $scope.login = function() {
        var dataObj = {
            email : $scope.loginEmail,
            password : $scope.loginPassword,
          };

        $http({
            method: 'POST',
            url: ConfigService.apiUrl() + 'login',
            data: {'session': dataObj},
            headers: { 'Content-Type': 'application/json' }
          })
          .success(function (data) {
            console.log('login response:', data);
            CurrentUserService.setUser(data.user);
            $cookieStore.put('auth_token', data.user.auth_token);
            $scope.loginError = '';
            $location.path('/feed');
          })
          .error(function (data) {
            console.log('Unsuccessful login:', data);
            $scope.loginError = data;
          });

      };

      $scope.signup = function() {
        var dataObj = {
            name : $scope.signupName,
            email : $scope.signupEmail,
            password : $scope.signupPassword,
            password_confirmation : $scope.confirmPassword
          };

        $http({
            method: 'POST',
            url: ConfigService.apiUrl() + 'users',
            data: {user: dataObj},
            headers: { 'Content-Type': 'application/json' }
          })
          .success(function (data) {
            console.log('Signup response:', data);
            CurrentUserService.setUser(data.user);
            $cookieStore.put('auth_token', data.user.auth_token);
            $scope.signupErrors = '';
            $('#signupModal').modal('hide');
            $location.path('/users/' + data.user.id);
          })
          .error(function (data) {
            console.log('Unsuccessful signup:', data);
            $scope.signupErrors = data.errors;
          });
      };

    }

  ]);
