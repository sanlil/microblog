'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
