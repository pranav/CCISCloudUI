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

CCISCloudUIControllers.controller 'BaseCtrl', ['$scope', 'UserCost', 'WhoAmI', ($scope, UserCost, WhoAmI) ->
  WhoAmI.getWhoIAm (whoiam) ->
    $scope.username = whoiam.username
    $scope.user_cost = UserCost.get_cost({user: $scope.username})
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
    window.location.href = "/"


]

CCISCloudUIControllers.controller 'CondenseCtrl', ['$scope', '$location', 'Instance', ($scope, $location, Instance) ->

  $scope.selectedInstanceType = 't2.micro'
  $scope.selectedAnsibleTask = 'base'
  $scope.disableCondenseButton = false

  $scope.setSelectedInstanceType = (instanceType) ->
    $scope.selectedInstanceType = instanceType

  $scope.isSelectedInstanceType = (instanceType) ->
    instanceType == $scope.selectedInstanceType

  $scope.setAnsibleTask = (ansibleTask) ->
    $scope.selectedAnsibleTask = ansibleTask

  $scope.isAnsibleTask = (ansibleTask) ->
    ansibleTask == $scope.selectedAnsibleTask

  $scope.condense_instance = ->
    $scope.disableCondenseButton = true
    Instance.condense({
      instanceId: 'condense',
      hostname: $scope.hostname,
      instance_type: $scope.selectedInstanceType,
      description: $scope.description,
      ansibleTask: $scope.selectedAnsibleTask
    }).$promise.then (result) ->
      $location.path "/instance/#{result.instance_id}"
      $scope.disableCondenseButton = false


]
