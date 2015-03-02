define ['SimpleComponent'], (SimpleComponent)->
  template = '
   <div class="simple-component selTitle"><h2>标题</h2>
        <hr/>
    </div>
      '
  scope =
    clazz: '@', title: '@'

  SimpleComponent.directive('sfTitleHr', [->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
  ])