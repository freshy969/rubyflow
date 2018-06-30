import React from "react"
import PropTypes from "prop-types"

class SubmitPostLink extends React.Component {
  constructor (props) {
    super(props);
    this.state = { postFormHidden: true };
    this.toggleNewPostForm = this.toggleNewPostForm.bind(this);
  }

  toggleNewPostForm () {
    if(this.state.postFormHidden) {
      this.setState({postFormHidden: false});
      console.log('show post form');
    } else {
      this.setState({postFormHidden: true});
      console.log('hide post form');
    }
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
