PublishAggregation 'packages',
  collection: -> MeteorPackages.Versions
  clientCollection: 'packages'
  filters: -> {}
  aggregation: (collection) ->
    collection.aggregate VersionsAggregation
