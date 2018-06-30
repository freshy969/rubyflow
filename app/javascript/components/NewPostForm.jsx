import React from "react"
import PropTypes from "prop-types"

class NewPostForm extends React.Component {
  constructor (props) {
    super(props);
  }
  render () {
    const { image_url } = this.props;

    return (
      <div className='container'>
        <div className='row justify-content-center'>
          <div className='col-md-8'>
            <form className="new_post" id="new_post">
              <h2>Submit a post</h2>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default NewPostForm
