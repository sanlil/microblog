'use strict';

angular.module('microblogApp')
  .factory('CurrentUserService', function($rootScope, $http, ConfigService) {

    var user = null;

    return {

      setUser: function(userData) {
        console.log('setUser()', userData);
        user = userData;
        $rootScope.$broadcast('user-updated');
      },

      getUser: function() {
        return user;
      },

      getName: function() {
        if (user) {
          return user.name;
        } else {
          return null;
        }
      },

      getPicture: function() {
        if (user && user.img) {
          return user.img;
        } else {
          return 'images/avatar.png';
        }
      },

      getId: function() {
        if (user) {
          return user.id;
        } else {
          return null;
        }
      },

      getMicroposts: function() {
        if (user && user.microposts) {
          return user.microposts;
        } else {
          return null;
        }
      },

      getFollowers: function() {
        if (user && user.followers) {
          return user.followers;
        } else {
          return [];
        }
      },

      getFollowing: function() {
        if (user && user.following) {
          return user.following;
        } else {
          return [];
        }
      },

      clearUser: function() {
        user = null;
        $rootScope.$broadcast('user-updated');
      }

    };
  });