CCISCloudUIApp = angular.module('CCISCloudUIApp', ['ngRoute', 'CCISCloudUIControllers'])

CCISCloudUIApp.config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true).hashPrefix('!')
  $routeProvider.when('/instances', {
    templateUrl: '/html/templates/instances.html',
    controller: 'InstancesCtrl'
  }).when('/condense', {
    templateUrl: '/html/templates/condense.html',
    controller: 'CondenseCtrl'
  }).otherwise({
    redirectTo: '/instances'
  })
])

CCISCloudUIControllers = angular.module('CCISCloudUIControllers', [])

CCISCloudUIControllers.controller 'BaseCtrl', ['$scope', ($scope) ->
  console.log 'basectrl'
]

CCISCloudUIControllers.controller 'InstancesCtrl', ['$scope', ($scope) ->
  console.log 'instancesctrl'
]
