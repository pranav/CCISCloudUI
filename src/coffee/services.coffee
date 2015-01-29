CCISCloudServices = angular.module('CCISCloudServices', ['ngResource'])

CCISCloudServices.factory 'Instance', ['$resource', ($resource) ->
  $resource '/api/v1/instance/:instanceId', { instanceId: "@instanceId" }, {
    query: { method: 'GET', params: { instanceId: 'all' }, isArray: true },
    action: { method: 'PUT' },
    delete: { method: 'DELETE' },
    condense: { method: 'POST' }
  }
]

CCISCloudServices.factory 'UserCost', ['$resource', ($resource) ->
  $resource '/api/v1/user/:user/cost', { user: '@user' }, {
    get_cost: { method: 'GET' }
  }
]