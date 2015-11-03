@PublishAggregation = (name, options) ->
  check name, String
  check options,
    collection: Function
    clientCollection: String
    filters: Function
    aggregation: Function

  Meteor.publish name, ->
    args = _.toArray arguments
    filters = options.filters.apply this, args
    collection = options.collection.apply this, args


    aggregate = =>
      options.aggregation.call this, collection, filters, args

    oldIds = []
    PublishAggregation = (initial) =>
      aggregations = aggregate()


      for aggregation in aggregations
        if initial
          @added options.clientCollection, aggregation._id, _.omit(aggregation, '_id')
        else
          if aggregation._id in oldIds
            @changed options.clientCollection, aggregation._id, _.omit(aggregation, '_id')
          else
            @added options.clientCollection, aggregation._id, _.omit(aggregation, '_id')
      for id in oldIds when not _.find(aggregations, (ag) -> ag._id is id)
        @removed options.clientCollection, id

      oldIds = _.pluck aggregations, '_id'
    PublishAggregation true

    initializing = true
    handle = collection.find(filters).observeChanges
      added: ->
        return if initializing
        PublishAggregation()
      changed: (id, fields) ->
        return if initializing
        PublishAggregation()
      removed: ->
        return if initializing
        PublishAggregation()
    initializing = false
    @onStop ->
      handle.stop()
    return @ready()
