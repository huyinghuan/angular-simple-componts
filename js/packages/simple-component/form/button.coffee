define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
  <div class="simple-component selButton"><input type="button" value="确定"></div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@'

  SimpleComponent.directive('sfButton',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean

      $(element).find("button").on('click', ->
        bean.formAction($scope.name)
      )
  ])