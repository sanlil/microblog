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
    'ngRoute',
    'ngCookies'
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
      when('/users/:id', {
        templateUrl: 'views/user.html',
        controller: 'UserCtrl',
        activetab: 'users'
      }).
      when('/create', {
        templateUrl: 'views/create.html',
        controller: 'CreateCtrl',
        activetab: 'create'
      }).
      otherwise({
        redirectTo: '/'
      });
  }
]);


