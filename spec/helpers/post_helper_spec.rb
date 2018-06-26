require 'rails_helper'

describe PostHelper do
  describe '#sanitize_post_content' do
    it 'returns sanitized post content' do
      input = "<p>paragraph</p><h1>header</h1><strong>bold</strong><em>em tag</em><a href=\"#\" target=\"_blank\">link</a></p>"
      expectation = "<p>paragraph</p>header<strong>bold</strong><em>em tag</em><a href=\"#\" target=\"_blank\">link</a>"
      allow(helper).to receive(:sanitize).with(
        input, tags: %w(strong p a i em), attributes: %w(href target)
      ).and_return(expectation)

      result = helper.sanitize_post_content(input)

      expect(result).to eq(expectation)
      expect(helper).to have_received(:sanitize).with(
        input, tags: %w(strong p a i em), attributes: %w(href target)
      ).once
    end
  end
end
