define ['SimpleComponent', 'jquery', 'select2'], (SimpleComponent, $, select2)->
  template = '
      <div class="simple-component selectBox {{clazz}}">
         <span class="boxText">{{title}}</span>
         <div class="selBox">
            <span></span>
            <select class="select" name="{{name}}"></select>
        </div>
      </div>
    '
  scope =
    bean: '=', clazz: '@', title: '@', name: '@', value: '@', init: '@'

  SimpleComponent.directive('sfSelect2', ["$timeout", "honey.utils", ($timeout, honeyUtils)->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      bean.formChange = bean.formChange or ()->
      $select = $(element).find("select")
      #flag 是否第一次加载数据
      loadData = (params = {}, flag = false)->
        bean.getList($scope.name, params).then((data)->
          setSelectData(data, flag)
          value = $scope.getValue(data[0])
          obj = {}
          obj[$scope.name] = value

          #如果非初次加载数据, 那么使用第一个值为select默认值, 接着触发表单改变事件
          if (not flag) and data[0]
            bean.formChange($scope.name, value)
            honeyUtils.setHash(obj)
#首次加载数据
          else
            hashValue = honeyUtils.getHashObj($scope.name)
            #查看当前hash的值是否存在于数组, 如果存在数组里面, 那么使用该hash值,如果不存在,则设为null
            hashValue = if isContained(data, hashValue) then  hashValue else null
            #如果hash存在,则用hash, 否则看是否设置 了默认值, 最后使用第一个数据
            value =  hashValue or $scope.value or value
            $select.val(value).trigger("change")
            bean.initFinish($scope.name, value)
        )

      isContained = (arr, value)->
        for item in arr
          itemValue = if item.value? then item.value else item
          return true if "#{value}" is "#{itemValue}"
        return false

      #是否主动初始化
      loadData({}, true) if "#{$scope.init}" isnt "0"

      setSelectData = (data, flag)->
        queue = []
        for item in data
          queue.push({
            id: if item?.value? then item.value else item
            text: if item.name? then item.name else item
          })

        if not flag
          $select.select2("destroy")
          $select.html("")

        $select.select2(data: queue)

      $scope.$on("sf-select2:#{$scope.name}:load", (e, data, flag)->
        loadData(data, flag)
      )

      $select.on("select2:select", (e)->
        bean.formChange($scope.name, e.params.data.id)
      )

      $scope.getValue = (item)-> if item?.value? then item.value else item
  ])
