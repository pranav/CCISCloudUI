CCISCloudServices = angular.module('CCISCloudServices', ['ngResource'])

CCISCloudServices.factory 'Instances', ['$resource', ($resource) ->
  $resource('/'
]