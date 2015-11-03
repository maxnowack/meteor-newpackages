@VersionsAggregation = [
  {
    $sort:
      published: 1
  }
  {
    $group:
      _id: '$packageName'
      packageName: $first: '$packageName'
      description: $first: '$description'
      longDescription: $first: '$longDescription'
      publishedBy: $first: '$publishedBy'
      published: $first: '$published'
      git: $first: '$git'
  }
  {$sort: 'published': -1},
  {$limit: 100},
]
