define(['app',  'moment', 'sc/base-service'], (app, moment, BaseFormService)->

  class Biz extends BaseFormService
    constructor: ->
      super

    timeBucket: ->
      @q({startDate: new Date(), endDate: moment()})

    testTime: ->
      @q(moment())

    testSelcet: ->
      @q(["有",23,4, 1,4,4, 2,4,4,3,3,2,3,23,21,321,3,123,21,3,123,13])

    testSelect2: ->
      @q([2,3,23,21,321,3,123,21,3,123,13])

  app.controller('CompontsController',['$scope', '$q', ($scope, $q)->

    biz = new Biz({}, $q)

    formChange = (name, value)->
      #设置hash或者其他事情
      console.log name, value

    initFinish = (name, value)->
      #设置hash或者其他事情
      console.log name, value

    getData = (name, params = {})->
      if biz[name] then biz[name]() else biz['default']()

    formAction = (name)->
      console.log name

    $scope.bean = {
      getData: getData
      getList: getData
      formChange: formChange
      formAction: formAction
      initFinish: initFinish
    }

    $('#loading').hide()
  ])
)