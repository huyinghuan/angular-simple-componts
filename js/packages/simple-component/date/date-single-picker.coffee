define [
  'SimpleComponent',
  'jquery',
  'moment'
  'bootstrap-daterangepicker'
], (SimpleComponent, $, _moment)->
  template = '
    <div class="simple-component seltime {{clazz}}">
          <span class="boxText">{{title}}</span>
          <input class="boxInput timeon" type="text" value="1212">
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

  scope = bean: '=', clazz: '@', title: '@', name: '@', format: "@", limit: '@'

  SimpleComponent.directive('sfDatesinglepicker',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      $input = $(element).find('input')
      bean = $scope.bean
      bean.getData($scope.name)
        .then((date)->
          options =
            opens: "left"
            format: $scope.format or "YYYY-MM-DD"
            startDate: date
            singleDatePicker: true
            locale: local

          $input.daterangepicker(options, (start)->
            bean.formChange and bean.formChange($scope.name, start)
          )
          $input.data('daterangepicker').setStartDate(date)
        )
  ])
