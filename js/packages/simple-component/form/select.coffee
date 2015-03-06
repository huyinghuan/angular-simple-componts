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
    bean: '=', clazz: '@', title: '@', name: '@', value: '@'

  SimpleComponent.directive('sfSelect', ["$timeout", "honey.utils", ($timeout, honeyUtils)->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      bean.formChange = bean.formChange or ()->
      $select = $(element).find("select")
      loadData = (params = {}, flag = false)->
        bean.getList($scope.name, params).then((data)->
          $scope.itemList = data
          if flag and data[0]
            value = data[0].value or data[0]
            obj = {}
            obj[$scope.name] = value
            bean.formChange($scope.name, value)
            honeyUtils.setHash(obj)
        )

      loadData()

      $select.on("change", ()->
        bean.formChange($scope.name, $(@).val())
      )

      #默认选择器
      $scope.isDefaultOption = (item)->
        value = item.value or item
        value is $scope.value

      $timeout(()->
        $scope.$on("sf-select:#{$scope.name}:load", (e, data)->
          loadData(data, true)
        )
      , 1000)
  ])
