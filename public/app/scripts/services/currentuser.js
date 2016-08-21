'use strict';

angular.module('microblogApp')
  .factory('CurrentUserService', function($rootScope) {

    var user = null;

    return {

      setUser: function(userData) {
        console.log('setUser()', userData);
        user = userData;
        $rootScope.$broadcast('login-done');
      },

      getUser: function() {
        return user;
      },

      getName: function() {
        return user.name;
      },

      getPicture: function() {
        return user.img;
      },

      getId: function() {
        return user.id;
      },

      clearUser: function() {
        user = null;
      }

    };
  });