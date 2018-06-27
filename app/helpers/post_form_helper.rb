module PostFormHelper
  def post_input_class(post, attribute)
    if post.errors[attribute].present?
      'form-control is-invalid'
    else
      'form-control'
    end
  end
end
