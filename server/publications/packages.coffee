PublishAggregation 'packages',
  collection: -> MeteorPackages.Versions
  clientCollection: 'packages'
  filters: -> {}
  aggregation: (collection) ->
    collection.aggregate [
      {
        $sort:
          published: 1
      }
      {
        $group:
          _id: '$packageName'
          packageName: $first: '$packageName'
          published: $first: '$published'
          git: $first: '$git'
      }
      {$sort: 'published': -1},
      {$limit: 1000},
    ]
