import React from "react"
import PropTypes from "prop-types"

class SubmitPostFormButton extends React.Component {
  constructor (props) {
    super(props);
  }

  render () {
    const { user_signed_in } = this.props;

    if (user_signed_in) {
      return (
        <input type="submit" name="commit" value="Save" className="btn" />
      );
    } else {
      return (
        <input type="submit" name="commit" value="Authenticate with Github" className="btn" />
      );
    }
  }
}

SubmitPostFormButton.propTypes = {
  user_signed_in: PropTypes.bool.isRequired
};

export default SubmitPostFormButton
