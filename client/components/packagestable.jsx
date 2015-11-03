PackagesTable = React.createClass({
  mixins: [ReactMeteorData],

  getMeteorData() {
    return {
      packages: Packages.find().fetch()
    }
  },

  renderPackages() {
    if(!this.data.packages) return <tr><td colSpan="2">no packages</td></tr>;
    return this.data.packages.map((pkg) => {
      return <Pkg key={pkg.packageName} pkg={pkg} />;
    });
  },

  render() {
    return (
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Published at</th>
          </tr>
        </thead>
        <tbody>
          {this.renderPackages()}
        </tbody>
      </table>
    );
  }
});
