define(
  ['angularAMD', 'jquery', 'sc', 'angular-ui-router'],
  (angularAMD)->
    app = angular.module("app", ['ui.router', 'simple.component'])
    app.config([
      '$locationProvider',
      '$urlRouterProvider',
      '$stateProvider',
      '$logProvider'
      ($locationProvider, $urlRouterProvider, $stateProvider, $logProvider)->
        #$locationProvider.html5Mode true
        $stateProvider
          .state("home", angularAMD.route(
              url: "/home"
              templateUrl: 'componts.html'
              controller: 'CompontsController'
              controllerUrl: 'componts-controller'
          ))
        $logProvider.debugEnabled(true)
        $urlRouterProvider.when("/", "/home")
    ])
    angularAMD.bootstrap(app)
)