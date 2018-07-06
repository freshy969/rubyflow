import React from "react"
import PropTypes from "prop-types"

class NewPostForm extends React.Component {
  constructor (props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.authenticateWithGithub = this.authenticateWithGithub.bind(this);
    this.onChangeAttribute = this.onChangeAttribute.bind(this);
    this.state = { title: null, content: null }

    if(this.props.user_signed_in) {
      this.state.button_label = 'Save'
    } else {
      this.state.button_label = 'Authenticate with Github'
    }
  }

  onChangeAttribute({ target }) {
    const { name, value } = target;
    this.setState({ [name]: value });
  }

  authenticateWithGithub (event) {
    event.preventDefault();
    document.location = "/users/auth/github";
  }

  handleSubmit (event) {
    event.preventDefault();
    let body = JSON.stringify({authenticity_token: this.props.csrf_token, post: {title: this.state.title, content: this.state.content} })
    $("div[class='invalid-feedback']").hide();
    $("div[class='invalid-feedback']").text('');
    fetch('http://localhost:3000/p', {
        method: 'POST',
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.props.csrf_token,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body,
        credentials: 'same-origin'
      }).then((response) => {return response.json()})
      .then((post) => {
        if(post.slug) {
          document.location = "/p/" + post.slug;
        } else {
          $.each(post, function(error_name, values) {
            let element_id = "#" + error_name + "_post_input div[class='invalid-feedback']";
            $.each(values, function(index, error) {
              $(element_id).append(error + "<br/>")
            });
            $(element_id).show();
          });
        };
      })
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
                  <input type="submit" name="commit" value={button_label} className="btn" />
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default NewPostForm
