require 'rails_helper'

describe PostFormHelper do
  describe '#post_input_class' do
    it 'returns `form-control` class if the given field is valid' do
      errors = {}
      post = instance_double(Post, errors: errors)

      expect(helper.post_input_class(post, :title)).to eq('form-control')
    end

    it 'returns `is-invalid form-control` class if the given field is invalid' do
      errors = { title: ['is invalid'] }
      post = instance_double(Post, errors: errors)

      expect(helper.post_input_class(post, :title)).to eq('form-control is-invalid')
    end
  end
end
