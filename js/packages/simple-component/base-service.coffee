define [], ->
  class Biz
    constructor: (@service, @$q)->
    q: (data)->
      deferred = @$q.defer()
      deferred.resolve(data)
      deferred.promise
    default: ()->
      @q(null)
      
