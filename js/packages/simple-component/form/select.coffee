define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
      <div class="simple-component selectBox">
       <div class="selBox">
          <select name="{{name}}" honey-hash-bind>
            <option
            ng-repeat="item in itemList track by $index"
            value="{{item.value || item}}"
            ng-selected="isDefaultOption(item)"
            honey-hash-bind
            >
            {{item.name || item}}
          </option>
         </select>
      </div>
    </div>
  '
  scope =
    bean: '=', clazz: '@', title: '@', name: '@', value: '@'

  SimpleComponent.directive('sfSelect', ["$timeout", ($timeout)->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean

      loadData = (params = {})->
        bean.getList($scope.name, params).then((data)->
          $scope.itemList = data
        )

      loadData()

      $(element).find("select").on("change", ()->
        bean.formChange and bean.formChange($scope.name, $(@).val())
      )

      #默认选择器
      $scope.isDefaultOption = (item)->
        value = item.value or item
        value is $scope.value

      $timeout(()->
        $scope.$on("sf-select:#{$scope.name}:load", (e, data)->
          loadData(data)
        )
      , 1000)
  ])
