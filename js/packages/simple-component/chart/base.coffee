define ['echarts', 'lodash', 'jquery'], (echarts, _, $)->
  class Base
    constructor: (container, setting = {})->
      @chartType = 'line'
      @initSetting(setting)
      @initContainer(container)
      @chart = echarts.init(container)
      @initDefualtOption()

    initSetting: (setting)->
      defaultSetting =
        width: 0.95
        height: 400

      setting.width = +setting.width or defaultSetting.width
      setting.height = +setting.height or defaultSetting.height
      @setting = setting
      @

    initContainer: (container)->
      parent = container.parentNode
      parentWidth = parent.clientWidth
      parentHeight = parent.clientHeight

      settingHeight = @setting.height
      settingWidth = @setting.width

      if settingHeight > 1
        container.style.height = "#{settingHeight}px"
      else
        container.style.height = "#{parentHeight  * settingHeight}px"

      if settingWidth > 1
        container.style.width = "#{settingWidth}px"
      else
        container.style.width = "#{parentWidth * settingWidth}px"

      @

    initDefualtOption: ->
      @option =
        title:
          text: ''
          subtext: ''
        tooltip: trigger: 'axis'
        legend: data: []
        toolbox: false
        calculable: true
        xAxis: []
        yAxis: [ { type: 'value' } ]
        series: []
        animation: false
      @

    setTitle: (title)->
      _.extend @option.title, title
      @

    setTooltip: (tooltip)->
      _.extend @option.tooltip, tooltip
      @

    setLegend: (legend)->
      _.extend @option.legend, legend
      @

    #从series中获取legend数据
    parseLegendFromSeries: (series)->
      series = series or []
      queue = []
      for item in series
        if _.isArray item
          queue.push item[0]
        else
          queue.push item.name
      @setLegend(data: queue)
      @

    setXAixs: (xAixs)->
      #如果使用的是简化的xAixs值，如xAxis: [['周一','周二','周三']］则自动补全
      for axis, index in xAixs
        if _.isArray axis
          xAixs[index] =
            type: 'category'
            boundaryGap: false
            data: axis

      @option.xAxis = xAixs or []
      @

    setYAixs: (yAixs)->
      @option.yAxis = yAixs if yAixs
      @

    setSeries: (series)->
      type = @chartType
      #如果使用的是简化yAixs值，如['成交', [10, 12, 21, 54, 260, 830, 710]] 则补全
      for serie, index in series
        if _.isArray serie
          series[index] =
            name: serie[0]
            type: type
            data: serie[1]
            symbol: 'none'
            smooth: true
            itemStyle: normal: areaStyle: type: 'default'

      @option.series = series or []
      @

    finish: ->
      @chart.setOption @option, true