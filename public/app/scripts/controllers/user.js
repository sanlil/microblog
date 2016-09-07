'use strict';

/**
 * Controller for showing a user's profile page
 */
angular.module('microblogApp')
  .controller('UserCtrl', ['$scope', '$http', '$routeParams', 'ConfigService', 'CurrentUserService',
    function ($scope, $http, $routeParams, ConfigService, CurrentUserService) {

      var getUserData = function() {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'users/' + $routeParams.id,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          $scope.user = data.user;
          $scope.microposts = data.user.microposts;
        })
        .error(function(data) {
          console.log(data);
        });
      };

      $scope.deletePost = function(micropostId) {
        console.log('DELETE, id: ' + micropostId);
        $http({
          method: 'DELETE',
          url: ConfigService.apiUrl() + 'microposts/' + micropostId,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log('success');
          console.log(data);
          $scope.microposts = data.microposts;
        })
        .error(function(data) {
          console.log(data);
        });
      };

      $scope.follow = function() {
        $http({
          method: 'POST',
          url: ConfigService.apiUrl() + 'follow/' + $routeParams.id,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log(data);
          CurrentUserService.setUser(data.user);
        })
        .error(function(data) {
          console.log(data);
        });
      };
      
      $scope.unfollow = function() {
        $http({
          method: 'DELETE',
          url: ConfigService.apiUrl() + 'unfollow/' + $routeParams.id,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log(data);
          CurrentUserService.setUser(data.user);
        })
        .error(function(data) {
          console.log(data);
        });
      };

      $scope.isOwnProfilePage = function() {
        return ($scope.userId === CurrentUserService.getId());
      };

      $scope.doesFollowUser = function() {
        return idInFollowList($scope.userId);
      };

      var idInFollowList = function(userId) {
        var list = CurrentUserService.getFollowing();
        var filteredList = list.filter(function(o) {
            return o.id === userId;
          });
        return filteredList.length >= 1;
      };

      (function() {
        getUserData();
        $scope.userId = parseInt($routeParams.id, 10);
      })();

    }
    
  ]);

