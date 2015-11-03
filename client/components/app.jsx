App = React.createClass({
  render() {
    return (
      <div className="container">
        <header>
          <h1>New packages</h1>
        </header>

        <PackagesTable />
      </div>
    );
  }
});
