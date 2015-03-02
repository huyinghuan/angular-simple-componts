define ['SimpleComponent', 'jquery.honey.pagination'], (SimpleComponent)->
  template = '<div></div>'

  scope = clazz: '@', title: '@', name: '@', bean: '='

  SimpleComponent.directive('sfPager',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      pager = $(element).pagination({pageIndex:1, pageCount: 1, href: false})

      $scope.$on("sf-pager:#{$scope.name}:go", (event, pageData)->
        pager.goto({pageIndex: pageData.pageIndex, pageCount: pageData.pageCount})
      )

      pager.on('goto', (e, data)->
        bean.formChange and bean.formChange($scope.name, data.pageIndex)
      )
  ])