HTTP.methods
  '/feed.xml': get: ->
    feed = new RSS
      title: 'Meteor Packages'
      description: 'New meteor packages on atmosphere'
      feed_url: 'http://newpackages.meteor.com/feed.xml'
      site_url: 'http://newpackages.meteor.com/'
      webMaster: 'max@unsou.de (Max Nowack)'
      custom_namespaces: {
        content: 'http://purl.org/rss/1.0/modules/content/'
      }

    markdownConverter = new Showdown.converter()
    MeteorPackages.Versions.aggregate(VersionsAggregation).forEach (pkg) ->
      feed.item
        title: pkg.packageName
        description: _.escape pkg.description
        custom_elements: [
          'content:encoded': markdownConverter.makeHtml pkg.longDescription
        ]
        url: "https://atmospherejs.com/#{pkg.packageName.replace(':','/')}"
        guid: pkg.packageName
        author: pkg.publishedBy.username
        date: pkg.published

    feed.xml(indent: true)
