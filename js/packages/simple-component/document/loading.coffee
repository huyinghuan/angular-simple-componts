define ['SimpleComponent'], (SimpleComponent)->
  template = '
    <div class="simple-component loading" id="loading">
        <div class="spinner">
          <div class="spinner-container container1">
              <div class="circle1"></div>
              <div class="circle2"></div>
              <div class="circle3"></div>
              <div class="circle4"></div>
          </div>
          <div class="spinner-container container2">
              <div class="circle1"></div>
              <div class="circle2"></div>
              <div class="circle3"></div>
              <div class="circle4"></div>
          </div>
          <div class="spinner-container container3">
              <div class="circle1"></div>
              <div class="circle2"></div>
              <div class="circle3"></div>
              <div class="circle4"></div>
          </div>
        </div>
        <div class="description">Loading...</div>
    </div>
  '
  scope = clazz: '@', title: '@'

  SimpleComponent.directive('sfLoading',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
  ])