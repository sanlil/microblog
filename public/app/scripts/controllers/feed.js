'use strict';

/**
 * Controller for showing a user's feed
 */
angular.module('microblogApp')
  .controller('FeedCtrl', ['$scope', '$http', 'ConfigService', 'CurrentUserService',
    function ($scope, $http, ConfigService, CurrentUserService) {

      var getFeed = function() {
        $http({
          method: 'GET',
          url: ConfigService.apiUrl() + 'feed',
          headers: {
            'Authorization': ConfigService.getToken()
          }
        })
        .success(function(data) {
          $scope.feed = data.feed;
        })
        .error(function(data) {
          console.log(data);
        });
      };
      getFeed();

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
            $scope.feed = getFeed();
          })
          .error(function (data) {
            $scope.error = data.status + ' ' + data.error;
            $scope.exception = data.exception;
          });
        }
      };

      $scope.isCurrentUser = function(userId) {
        return CurrentUserService.getId() === userId;
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
          getFeed();
        })
        .error(function(data) {
          console.log('could not delete post:', data);
        });
      };

    }
  ]);

