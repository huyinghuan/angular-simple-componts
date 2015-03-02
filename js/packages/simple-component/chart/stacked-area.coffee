###
  面积堆积图
###
define ['SimpleComponent', 'jquery', './base', 'echarts', 'echarts/chart/line']
, (SimpleComponent, $, Base, echarts)->
  template = '<div></div>'

  scope =
    bean: '='
    name: '@'
    clazz: '@'
    headTitle: '@'
    chartWidth: '@'
    chartHeight: '@'
    chartData: '='

  class StackedArea extends Base
    constructor: -> super

  SimpleComponent.directive('sfStackedArea',['$timeout', ($timeout)->
    restrict: 'AE'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      chartElement = element[0]
      chart = null


      setChartOptions = (data)->
        chart.parseLegendFromSeries(data.series)
        .setXAixs(data.xAxis)
        .setYAixs(data.yAxis)
        .setSeries(data.series)
        .setTitle(data.title)
        .setTooltip(data.tooltip)
        .finish()

      initChart = (data)->
        chart = new StackedArea(chartElement,
          {
            width: $scope.chartHeight,
            height: $scope.chartWidth
          })
        data = data or {}

        chart.setTitle(text: $scope.title, subtext: $scope.subTitle)
        setChartOptions(data)

      $timeout(->
        $scope.$watch('chartData', ->
          return if not $scope.chartData?
          if not chart?
            initChart($scope.chartData)
          else
            setChartOptions($scope.chartData)
        )
      )
  ])