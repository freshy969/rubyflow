import React from "react"
import PropTypes from "prop-types"
import SubmitPostFormButton from "./SubmitPostFormButton"
import { postRequest } from "../lib/request.js"

class NewPostForm extends React.Component {
  constructor (props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.authenticateWithGithub = this.authenticateWithGithub.bind(this);
    this.onChangeAttribute = this.onChangeAttribute.bind(this);
    this.state = { title: null, content: null }
  }

  onChangeAttribute({ target }) {
    const { name, value } = target;
    this.setState({ [name]: value });
  }

  authenticateWithGithub (event) {
    event.preventDefault();
    document.location = "/users/auth/github";
  }

  renderErrorsOnForm (errors) {
    $.each(errors, function(error_name, values) {
      let element_id = "#" + error_name + "_post_input div[class='invalid-feedback']";
      $.each(values, function(index, error) {
        $(element_id).append(error + "<br/>")
      });
      $(element_id).show();
    });
  }

  handleResponse (post, context) {
    if(post.slug) {
      document.location = "/p/" + post.slug;
    } else {
      context.renderErrorsOnForm(post);
    };
  }

  handleSubmit (event) {
    event.preventDefault();
    let body = JSON.stringify({authenticity_token: this.props.csrf_token, post: {title: this.state.title, content: this.state.content} })
    $("div[class='invalid-feedback']").hide();
    $("div[class='invalid-feedback']").text('');
    postRequest(
      "p", 
      this.props.csrf_token, body, this.handleResponse, this
    );
  }

  render () {
    const { image_url, user_signed_in } = this.props;
    const { button_label} = this.state;

    return (
      <div className='container'>
        <div className='row justify-content-center'>
          <div className='col-md-8'>
            <form className="new_post" id="new_post" onSubmit={user_signed_in ? this.handleSubmit : this.authenticateWithGithub }>
              <h2>Submit a post</h2>
              <div className='row'>
                <div className='col-md-1'>
                  <img src={image_url} />
                </div>
                <div className='col-md-11'>
                  <div className='form-group' id="title_post_input">
                    <input className="form-control" placeholder="Title" type="text" name="title" id="post_title" onChange={this.onChangeAttribute} />
                    <div className="invalid-feedback" style={{display: 'none'}}></div>
                  </div>
                  <div className='form-group' id="content_post_input">
                    <textarea className="form-control" style={{minHeight: '200px'}} placeholder="Type your content here, including links. At least, explain the content around your link in a single paragraph." name="content" id="post_content" onChange={this.onChangeAttribute}>
                    </textarea>
                    <div className="invalid-feedback" style={{display: 'none'}}></div>
                  </div>
                  <small className='form-text text-muted'>You can use Markdown.
                    <br/>
                    Note that your post may be edited to suit the format of the site.
                  </small>
                  <SubmitPostFormButton user_signed_in={user_signed_in}/>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

NewPostForm.propTypes = {
  user_signed_in: PropTypes.bool.isRequired,
  csrf_token: PropTypes.string.isRequired
};

export default NewPostForm
