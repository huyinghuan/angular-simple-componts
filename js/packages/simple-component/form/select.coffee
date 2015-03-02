define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
     <div class="simple-component sel {{clazz}}">
      <span class="seltext">{{title}}</span>
      <div class="selbg">
        <a href=""></a>
        <select class="sellist" name="{{name}}" honey-hash-bind>
          <option
            ng-repeat="item in itemList"
            value="{{item.value || item}}"
            honey-hash-bind
            ng-selected="isDefaultOption(item)"
            >
            {{item.name || item}}
          </option>
        </select>
      </div>
    </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@', value: '@'

  SimpleComponent.directive('sfSelect',["$timeout", ($timeout)->
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
