Packages = new Mongo.Collection('packages');

Meteor.startup( () => {
  Meteor.subscribe('packages');
  React.render(<App />, document.getElementById("render-target"));
});
