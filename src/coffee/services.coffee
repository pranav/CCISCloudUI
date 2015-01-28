CCISCloudServices = angular.module('CCISCloudServices', ['ngResource'])

CCISCloudServices.factory 'Instance', ['$resource', ($resource) ->
  $resource '/api/v1/instance/:instanceId', { instanceId: "@instanceId" }, {
    query: { method: 'GET', params: { instanceId: 'all' }, isArray: true },
    action: { method: 'PUT' }
  }
]