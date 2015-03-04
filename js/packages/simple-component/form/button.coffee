define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
  <div class="simple-component selButton {{clazz}}">
    <input type="button" value="{{title}}">
  </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@'

  SimpleComponent.directive('sfButton',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean

      $(element).find("input:button").on('click', ->
        bean.formAction($scope.name)
      )
  ])