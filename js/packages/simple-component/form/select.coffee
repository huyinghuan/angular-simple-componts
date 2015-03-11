define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
      <div class="simple-component selectBox">
         <span class="boxText">{{title}}</span>
         <div class="selBox">
            <span></span>
            <select class="select" name="{{name}}" honey-hash-bind>
              <option
                ng-repeat="item in itemList track by $index"
                value="{{item.value || item}}"
                ng-selected="isDefaultOption(item)"
                honey-hash-bind>
              {{item.name || item}}
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
          value = data[0].value or data[0]
          obj = {}
          obj[$scope.name] = value
          #如果非初次加载 那么触发表单改变事件
          if (not flag) and data[0]
            bean.formChange($scope.name, value)
            honeyUtils.setHash(obj)
          else
            value = honeyUtils.getHashObj($scope.name) or value
            bean.initFinish($scope.name, value)

        )

      #是否主动初始化
      if "#{$scope.init}" isnt "0"
        loadData({}, true)

      $select.on("change", ()->
        bean.formChange($scope.name, $(@).val())
      )

      #默认选择器
      $scope.isDefaultOption = (item)->
        value = item.value or item
        value is $scope.value

      $scope.$on("sf-select:#{$scope.name}:load", (e, data, flag)->
        loadData(data, flag)
      )
  ])
