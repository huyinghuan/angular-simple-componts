((define, require)->
  #定义主入口
  define 'SimpleComponent', ['angular', 'angular-bind-hash'], (angular)->
    angular.module('simple.component', ['honey.hashBind'])

  #加载其他组建
  define [
    './form/select'
    './form/input'
    './form/button'
    './date/date-range-picker'
    './date/date-single-picker'
    './document/title-hr'
    './document/pager'
    './document/loading'
#    './chart/line-surface'
#    './chart/stacked-area'
#    './chart/pie'
  ], ()->

)(define, require)
