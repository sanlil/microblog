'use strict';

/**
 * @ngdoc overview
 * @name microblogApp
 * @description
 * # microblogApp
 *
 * Main module of the application.
 */
var app = angular.module('microblogApp', [
    'ngRoute'
  ]);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl',
        activetab: 'login'
      }).
      when('/users', {
        templateUrl: 'views/users.html',
        controller: 'UsersCtrl',
        activetab: 'users'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);


