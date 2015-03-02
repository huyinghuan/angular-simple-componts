define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
     <div class="simple-component selPull clearfix">
        <span class="boxText">选择省份：</span>
        <div class="pullbox"><a href="#" class="sub on" tabindex="1">下拉选择框</a>
            <ul class="pullul">
                <li>Link 6</li>
                <li>Link 7</li>
                <li>Link 8</li>
                <li>Link 9</li>
                <li>Link 10</li>
            </ul>
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
