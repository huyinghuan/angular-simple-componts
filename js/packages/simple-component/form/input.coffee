define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
 <div class="simple-component selInput">
      <input class="boxInput"  type="text" value="1212">
  </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@', value: '@'

  SimpleComponent.directive('sfInput',[->
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
          bean.formChange and bean.formChange($scope.name, $(@).val())
      )

  ])
