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
          console.log('get userdata response: ', data);
          $scope.user = data.user;
          $scope.microposts = data.user.microposts;
          $scope.following = data.user.following;
          $scope.followers = data.user.followers;
        })
        .error(function(data) {
          console.log('could not fetch userdata: ', data);
          console.log(data);
        });
      };

      $scope.deletePost = function(micropostId) {
        $http({
          method: 'DELETE',
          url: ConfigService.apiUrl() + 'microposts/' + micropostId,
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          console.log('delete post response: ', data);
          $scope.microposts = data.microposts;
        })
        .error(function(data) {
          console.log('could not delete post:', data);
        });
      };

      $scope.createNewPost = function() {
        if ($scope.newMicropost && $scope.newMicropost.length > 0 && $scope.newMicropost.length < 140) {
          $http({
            method: 'POST',
            url: ConfigService.apiUrl() + 'microposts',
            data: {'micropost': {'content': $scope.newMicropost}},
            headers: {
              'Content-Type': 'application/json',
              'Authorization': ConfigService.getToken()
            }
          })
          .success(function () {
            $scope.newMicropost = '';
            $scope.feed = getUserData();
            $('#createNewModal').modal('hide');
          })
          .error(function (data) {
            $scope.error = data.status + ' ' + data.error;
            $scope.exception = data.exception;
          });
        }
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
          console.log('follow user response', data);
          CurrentUserService.setUser(data.user);
          getUserData();
        })
        .error(function(data) {
          console.log('could not follow user', data);
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
          console.log('unfollow user response', data);
          CurrentUserService.setUser(data.user);
          getUserData();
        })
        .error(function(data) {
          console.log('could not unfollow user', data);
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

      /**
       * Initialization
       */
      (function() {
        $('.modal-backdrop').hide();
        getUserData();
        $scope.userId = parseInt($routeParams.id, 10);
      })();

    }
    
  ]);

