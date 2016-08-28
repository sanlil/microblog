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
          return null;
        }
      },

      getId: function() {
        if (user) {
          return user.id;
        } else {
          return null;
        }
      },

      clearUser: function() {
        user = null;
        $rootScope.$broadcast('user-updated');
      }

    };
  });