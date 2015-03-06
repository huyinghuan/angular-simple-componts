define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
     <div class="simple-component selPull clearfix">
        <span class="boxText">{{title}}：</span>
        <div class="pullbox">
            <a href="javascript:void(0)" class="sub" ng-class="{on: open}" tabindex="1"
              ng-click="showPull()">{{itemList[0].name || itemList[0]}}</a>
            <ul class="pullul" style="display: none;">
                <li ng-repeat="item in itemList track by $index"
                  ng-click="selectItem(item)">{{item.name || item}}</li>
            </ul>
        </div>
   </div>
    '
  scope =
    bean: '=', clazz: '@', title: '@', name: '@', value: '@'

  SimpleComponent.directive('sfSelectAnalog', ["$timeout", "honey.utils",($timeout, honeyUtils)->
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

      $timeout(()->
        $scope.$on("sf-select:#{$scope.name}:load", (e, data)->
          loadData(data)
        )
      , 1000)

      $ul = $(element).find('ul')

      $scope.showPull = ->
        $scope.open = not $scope.open
        if $scope.open then $ul.show() else $ul.hide()
        return

      $a = $(element).find('a')

      setHash = (name, value)->
        obj = {}
        obj[name] = value
        honeyUtils.setHash(obj)

      $scope.selectItem = (item)->
        value = item.value or item
        $a.html(item.name or item)
        bean.formChange and bean.formChange($scope.name, value)
        $scope.showPull()
        setHash($scope.name, value)

  ])
