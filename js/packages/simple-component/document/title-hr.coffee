define ['SimpleComponent'], (SimpleComponent)->
  template = '
    <div class="simple-component title-hr">
      <strong>{{title}}</strong>
    </div>
  '
  scope = clazz: '@', title: '@'

  SimpleComponent.directive('sfTitleHr',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
  ])