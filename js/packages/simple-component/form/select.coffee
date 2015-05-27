define ['SimpleComponent', 'jquery', 'lodash'], (SimpleComponent, $)->
  template = '
      <div class="simple-component selectBox {{clazz}}">
         <span class="boxText">{{title}}</span>
         <div class="selBox">
            <span></span>
            <select class="select" name="{{name}}">
              <option
                ng-repeat="item in itemList track by $index"
                value="{{getValue(item)}}"
                ng-selected="isDefaultOption(item, itemList)">
              {{getName(item)}}
              </option>
            </select>
        </div>
      </div>
    '
  scope =
    bean: '=', clazz: '@', title: '@', name: '@', value: '@', init: '@'

  SimpleComponent.directive('sfSelect', ["$timeout", "honey.utils", ($timeout, honeyUtils)->
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
          $scope.itemList = data
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
            bean.initFinish($scope.name, value)
        )

      isContained = (arr, value)->
        for item in arr
          itemValue = if item.value? then item.value else item
          return true if value is itemValue
        return false

      #是否主动初始化
      if "#{$scope.init}" isnt "0"
        loadData({}, true)

      $select.on("change", ()->
        bean.formChange($scope.name, $(@).val())
      )

      #默认选择器
      $scope.isDefaultOption = (item, data)->
        hashValue = honeyUtils.getHashObj($scope.name)
        #查看当前hash的值是否存在于数组, 如果存在数组里面, 那么使用该hash值,如果不存在,则设为null
        hashValue = if isContained(data, hashValue) then  hashValue else null
        toBeSelectedValue = hashValue or $scope.value
        value = $scope.getValue(item)
        value is toBeSelectedValue

      $scope.$on("sf-select:#{$scope.name}:load", (e, data, flag)->
        loadData(data, flag)
      )

      $scope.getValue = (item)-> if item?.value? then item.value else item
      $scope.getName = (item)-> if item.name? then item.name else item
  ])
