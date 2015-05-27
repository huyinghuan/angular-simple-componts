define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
  <div class="simple-component selInput">
      <span class="boxText">{{title}}</span>
      <input class="boxInput"  type="text" value="{{value}}" placeholder="{{placeholder}}">
  </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@', value: '@', placeholder: '@'

  SimpleComponent.directive('sfInput',["honey.utils", (honeyUtils)->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      bean.getData($scope.name).then((data)->
        $scope.value = if not data? then "" else data
      )

      $(element).find("input").on("keyup", (e)->
        if e.keyCode is 13
          e.preventDefault()
          obj = {}
          obj[$scope.name] = $(@).val()
          honeyUtils.setHash(obj)
          bean.formChange and bean.formChange($scope.name, $(@).val())
      ).blur(()->
        obj = {}
        obj[$scope.name] = $(@).val()
        honeyUtils.setHash(obj)
        bean.formChange and bean.formChange($scope.name, $(@).val())
      )

  ])
