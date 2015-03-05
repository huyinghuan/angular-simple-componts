define [
  'SimpleComponent',
  'jquery',
  'moment'
  'bootstrap-daterangepicker'
], (SimpleComponent, $, _moment)->
  template = '
    <div class="simple-component seltime">
      <span class="boxText">{{title}}</span>
      <input class="boxInput timeon" type="text">
    </div>'

  ###
    本地化
  ###
  local =
    applyLabel: '确定',
    cancelLabel: '取消',
    fromLabel: '开始',
    toLabel: '结束',
    weekLabel: 'W',
    customRangeLabel: '自定义时间',
    daysOfWeek:  ["日", "一", "二", "三", "四", "五", "六"]
    monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]

  ranges =
    '今天': [
      new Date()
      new Date()
    ]
    "最近七天": [
      _moment().subtract("days", 6)
      new Date()
    ]
    "最近30天": [
      _moment().subtract("days", 29)
      new Date()
    ]
    "本月": [
      _moment().startOf("month")
      _moment().endOf("month")
    ]

  scope = bean: '=', clazz: '@', title: '@', name: '@', format: "@", limit: '@'

  SimpleComponent.directive('sfDaterangepicker',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      $input = $(element).find('input')
      bean = $scope.bean
      bean.getData($scope.name)
        .then((timeBucket)->
            timeBucket = timeBucket or {startDate: new Date(), endDate: new Date()}
        )
        .then((timeBucket)->

          options =
            ranges: ranges
            opens: "left"
            format: $scope.format or "YYYY-MM-DD"
            startDate: timeBucket.startDate
            endDate: timeBucket.endDate
            timePicker: true
            locale: local

          $input.daterangepicker(options, (start, end)->
            limit = +$scope.limit
            if not limit
              bean.formChange and bean.formChange($scope.name, [start, end])
              return

            maxDate = moment(start).add(limit, "days").startOf('day')
            if end.isAfter(maxDate)
              alert "选择时期超过限制"
              end = maxDate
              $input.data('daterangepicker').setEndDate maxDate

            bean.formChange and bean.formChange($scope.name, [start, end])
          )
          $input.data('daterangepicker').setStartDate(timeBucket.startDate)
          $input.data('daterangepicker').setEndDate(timeBucket.endDate)
        )
  ])
