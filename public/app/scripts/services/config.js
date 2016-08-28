'use strict';

angular.module('microblogApp')
  .factory('ConfigService', function ($cookieStore) {

    var apiAdress = 'http://localhost:3000/';

    return {

      apiUrl: function() {
        return apiAdress;
      },

      getToken: function() {
        return $cookieStore.get('auth_token');
      }

    };

  });