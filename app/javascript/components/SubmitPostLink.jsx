import React from "react"
import PropTypes from "prop-types"

class SubmitPostLink extends React.Component {
  constructor (props) {
    super(props);
  }

  toggleNewPostForm () {
    console.log('toggle post form');
  }

  render () { 
    return (
      <span onClick={this.toggleNewPostForm}>
        <i className="fa fa-plus"></i> Submit
      </span>
    );
  }
}

export default SubmitPostLink
