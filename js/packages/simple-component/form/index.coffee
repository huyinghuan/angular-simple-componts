((define, require)->
  #定义主入口
  define 'SimpleComponent', ['angular', 'angular-bind-hash'], (angular)->
    angular.module('simple.component', ['honey.hashBind'])

  #加载其他组建
  define [
    './select-analog'
    './select'
    './select2'
    './input'
    './button'
  ], ()->

)(define, require)
