define(['app',  'moment', 'sc/base-service'], (app, moment, BaseFormService)->

  class Biz extends BaseFormService
    constructor: ->
      super

    timeBucket: ->
      @q({startDate: new Date(), endDate: moment()})

    testTime: ->
      @q( moment())

    testSelcet: ->
      @q([1,23,4])

  app.controller('CompontsController',['$scope', '$q', ($scope, $q)->

    biz = new Biz({}, $q)

    formChange = (name, value)->

    getData = (name, params = {})->
      if biz[name] then biz[name]() else biz['default']()

    formAction = (name)->
      console.log name

    $scope.bean = {
      getData: getData
      getList: getData
      formChange: formChange
      formAction: formAction
    }
  ])
)