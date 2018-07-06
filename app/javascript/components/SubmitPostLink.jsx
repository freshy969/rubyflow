import React from "react"
import ReactDOM from "react-dom"
import PropTypes from "prop-types"
import NewPostForm from "./NewPostForm"

class SubmitPostLink extends React.Component {
  constructor (props) {
    super(props);
    this.state = { postFormHidden: true };
    this.toggleNewPostForm = this.toggleNewPostForm.bind(this);
  }

  toggleNewPostForm () {
    if(this.state.postFormHidden) {
      this.setState({postFormHidden: false});
      ReactDOM.render(<NewPostForm csrf_token={this.props.csrf_token} image_url={this.props.image_url} user_signed_in={this.props.user_signed_in} />, $('#new_post_form')[0]);
    } else {
      this.setState({postFormHidden: true});
      ReactDOM.unmountComponentAtNode($('#new_post_form')[0]);
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
