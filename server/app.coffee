@RSS = Meteor.npmRequire('rss')

Meteor.startup ->
  MeteorPackages.startSyncing()
