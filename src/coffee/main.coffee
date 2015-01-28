CCISCloudUIApp = angular.module('CCISCloudUIApp', ['ngRoute', 'CCISCloudUIControllers', 'CCISCloudServices'])

CCISCloudUIApp.config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true).hashPrefix('!')
  $routeProvider.when('/instances', {
    templateUrl: '/html/templates/instances.html',
    controller: 'InstancesCtrl'
  }).when('/instance/:instanceId', {
    templateUrl: '/html/templates/instance.html',
    controller: 'InstanceCtrl'
  }).when('/condense', {
    templateUrl: '/html/templates/condense.html',
    controller: 'CondenseCtrl'
  }).otherwise({
    redirectTo: '/instances'
  })
])

CCISCloudUIControllers = angular.module('CCISCloudUIControllers', [])

CCISCloudUIControllers.controller 'BaseCtrl', ['$scope', ($scope) ->
]

CCISCloudUIControllers.controller 'InstancesCtrl', ['$scope', 'Instance', ($scope, Instance) ->
  $scope.instances = Instance.query()
]

CCISCloudUIControllers.controller 'InstanceCtrl', ['$scope', '$routeParams','Instance', ($scope, $routeParams, Instance) ->
  $scope.instance = Instance.get({instanceId: $routeParams.instanceId})

  $scope.instance_action = (action) ->
    Instance.action({instanceId: $scope.instance.instance_id, action: action})
]
