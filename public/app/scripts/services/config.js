'use strict';

angular.module('microblogApp')
  .factory('ConfigService', function () {

    var apiAdress = 'http://localhost:3000/';

    return {

      apiUrl: function() {
        return apiAdress;
      }

    };

  });