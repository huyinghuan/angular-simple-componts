((define, require)->
  #定义主入口
  define 'SimpleComponent', ['angular', 'angular-bind-hash'], (angular)->
    angular.module('simple.component', ['honey.hashBind'])

  #加载其他组建
  define [
    './form/index'
    './date/index'
    './document/index'
    './chart/index'
  ], ()->

)(define, require)
