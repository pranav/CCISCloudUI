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

CCISCloudUIControllers.controller 'BaseCtrl', ['$scope', 'UserCost', ($scope, UserCost) ->
  $scope.user_cost = UserCost.get_cost({user: 'hyfi'})
]

CCISCloudUIControllers.controller 'InstancesCtrl', ['$scope', 'Instance', ($scope, Instance) ->
  $scope.instances = Instance.query()
]

CCISCloudUIControllers.controller 'InstanceCtrl', ['$scope', '$routeParams','Instance', ($scope, $routeParams, Instance) ->
  $scope.buttonStatus = [false, false, false, false]


  $scope.instance = Instance.get { instanceId: $routeParams.instanceId }

  $scope.instance_action = (action, buttonId) ->
    $scope.buttonStatus[buttonId] = true
    Instance.action { instanceId: $scope.instance.instance_id, action: action }, (success) ->
      if success.status == "success"
        alert("Successfully #{action}ed the instance")
        $scope.buttonStatus[buttonId] = false
    , (failure) ->
      alert("ERROR: #{failure}")
      $scope.buttonStatus[buttonId] = false

  $scope.delete_instance = ->
    Instance.delete { instanceId: $scope.instance.instance_id }


]

CCISCloudUIControllers.controller 'CondenseCtrl', ['$scope', '$location', 'Instance', ($scope, $location, Instance) ->
  $scope.puppetClass = "ccis::role_base"
  $scope.puppetClasses = [
    { puppetClass: 'ccis::role_base', title: 'Nothing' },
    { puppetClass: 'ccis::role_mysql', title: 'MySQL' },
    { puppetClass: 'ccis::role_nginx', title: 'Nginx' },
    { puppetClass: 'ccis::role_app_server', title: 'App Server' },
    { puppetClass: 'ccis::hadoop::role_tasktracker', title: 'Tasktracker' },
    { puppetClass: 'ccis::role_bitcoin_miner', title: 'Bitcoin Miner' }
  ]

  $scope.selectedInstanceType = 't2.micro'

  $scope.setSelectedInstanceType = (instanceType) ->
    $scope.selectedInstanceType = instanceType

  $scope.isSelectedInstanceType = (instanceType) ->
    instanceType == $scope.selectedInstanceType

  $scope.isActive = (pc) ->
    $scope.puppetClass == pc

  $scope.set_puppet_class = (pc) ->
    $scope.puppetClass = pc


  $scope.condense_instance = ->
    Instance.condense {
      instanceId: 'condense',
      hostname: $scope.hostname,
      instance_type: $scope.selectedInstanceType,
      description: $scope.description,
      puppetClass: $scope.puppetClass
    }
    $location.path("/instance/#{$scope.hostname}")


]
