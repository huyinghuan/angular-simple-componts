define ['SimpleComponent'], (SimpleComponent)->
  template = '
   <div class="simple-component selTitle">
    <h2>{{title || titleParent}}</h2>
    <hr ng-if="!hidehr"/>
    </div>
  '
  scope =
    clazz: '@', title: '@', hidehr: '@', titleParent: '='

  SimpleComponent.directive('sfTitleHr', [->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
  ])