Pkg = React.createClass({
  render() {
    return (
      <tr>
        <td><a href={this.props.pkg.git}>{this.props.pkg.packageName}</a></td>
        <td>{moment(this.props.pkg.published).format('LLL')}</td>
      </tr>
    );
  }
});
