import React from "react"
import PropTypes from "prop-types"
import SubmitPostFormButton from "./SubmitPostFormButton"
import { postRequest } from "../lib/request.js"

class NewCommentForm extends React.Component {
  constructor (props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.authenticateWithGithub = this.authenticateWithGithub.bind(this);
    this.onChangeAttribute = this.onChangeAttribute.bind(this);
    this.state = { body: null }
  }

  onChangeAttribute({ target }) {
    const { name, value } = target;
    this.setState({ [name]: value });
  }

  authenticateWithGithub (event) {
    event.preventDefault();
    document.location = "/users/auth/github";
  }

  renderErrorsOnForm (message) {
    let element_id = "#body_comment_input div[class='invalid-feedback']";
    $(element_id).append(message);
    $(element_id).show();
  }

  handleResponse (comment, context) {
    if(comment.success) {
      document.location = "/p/" + context.props.post_id;
    } else {
      context.renderErrorsOnForm(comment.message);
    };
  }

  handleSubmit (event) {
    event.preventDefault();
    let body = JSON.stringify({authenticity_token: this.props.csrf_token, comment: {body: this.state.body} })
    $("div[class='invalid-feedback']").hide();
    $("div[class='invalid-feedback']").text('');

    postRequest(
      "http://localhost:3000/p/" + this.props.post_id + "/comments", 
      this.props.csrf_token, body, this.handleResponse, this
    );
  }

  render () {
    const { image_url, user_signed_in } = this.props;

    return (
      <div className='row'>
        <div className='col-md-12'>
          <form className="new_comment" id="new_comment" onSubmit={user_signed_in ? this.handleSubmit : this.authenticateWithGithub }>
            <h2>Post a comment</h2>
            <div className='row'>
              <div className='col-md-1'>
                <img src={image_url} />
              </div>
              <div className='col-md-11'>
                <div className='form-group' id="body_comment_input">
                  <textarea className="form-control" style={{minHeight: "200px"}} placeholder="Type your comment here" name="body" id="comment_body" onChange={this.onChangeAttribute}></textarea>
                  <div className="invalid-feedback" style={{display: 'none'}}></div>
                </div>
                <SubmitPostFormButton user_signed_in={user_signed_in}/>
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  }
}

NewCommentForm.propTypes = {
  post_id: PropTypes.string.isRequired,
  csrf_token: PropTypes.string.isRequired,
  user_signed_in: PropTypes.bool.isRequired
};

export default NewCommentForm
