'use strict';

/**
 * @ngdoc function
 * @name microblogApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the microblogApp
 */
angular.module('microblogApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
