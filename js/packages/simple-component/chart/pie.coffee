define ['SimpleComponent', './base', 'echarts', 'echarts/chart/pie']
, (SimpleComponent, Base, echarts)->
  template = '<div></div>'

  scope =
    bean: '='
    name: '@'
    clazz: '@'
    chartData: '='

  class Pie extends Base
    constructor: ->
      super
      @option =
        title:
          text: ''
          subtext: ''
          x: "center"
        tooltip:
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        legend:
          orient : 'vertical',
          x : 'right',
          orient : 'vertical'
          data: []
        toolbox: false
        calculable: true
        series: [{
          name: "Disk"
          type: 'pie'
          radius: ['50%', '70%']
          data: []
          itemStyle:
            normal:
              label: show : false
              labelLine:  show : false
            emphasis:
              label:
                formatter: (seriesName, itemName, value, precent)->
                  return "#{itemName.replace("vfs.fs.size", "")} \n #{value}"
                show: true,
                position: 'center'
                textStyle: fontSize : '24', fontWeight : 'bold'
        }]
        animation: false

  SimpleComponent.directive('sfPie',['$timeout', ($timeout)->
    restrict: 'AE'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      chartElement = element[0]
      chart = null

      setChartOptions = (data)->
        chart.setTitle(text: data.title)
        chart.option.legend.data = data.legendData
        chart.option.series[0].data = data.data
        chart.option.series[0].itemStyle.emphasis.label.formatter =  (seriesName, itemName, value)->
          return "#{itemName.replace("vfs.fs.size", "")} \n #{value} #{data.unit}"

        chart.finish()

      initChart = (data)->
        chart = new Pie(chartElement, { width: null, height: null })
        data = data or {}
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