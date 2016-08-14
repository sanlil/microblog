'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:LoginctrlCtrl
 * @description
 * # LoginctrlCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('LoginCtrl', ['$scope', '$http', '$location', 'ConfigService',
    function ($scope, $http, $location, ConfigService) {
      
      $scope.email = '';
      $scope.password = '';
      $scope.loginErrors = '';
      $scope.signupErrors = '';

      $scope.login = function() {
        console.log('CLICK LOGIN!');
        console.log('email: ' + $scope.loginEmail + ' password: ' + $scope.loginPassword);
      };

      $scope.signup = function() {
        console.log('CLICK SIGNUP!');

        console.log('email: ' + $scope.signupEmail + ' name: ' + $scope.signupName + ' password: ' + $scope.signupPassword + ' confirm: ' + $scope.confirmPassword);

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
          .success(function (data, status, headers, config) {
            console.log('data:', data);
            console.log('status:', status);
            $scope.signupErrors = '';
            $('#signupModal').modal('hide');
            $location.path('/users');
            
          })
          .error(function (data, status, headers, config) {
            console.log( 'failure message: ' + JSON.stringify({data: data}));
            console.log('data:', data);
            console.log('status:', status);
            $scope.signupErrors = data;
          });
      };

    }

  ]);
