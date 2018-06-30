require 'rails_helper'

describe CommentDecorator do
  describe '#body' do
    it 'returns formatted content' do
      comment = instance_double(Comment, body: 'content')
      formatted_content = 'formatted content'
      allow(Posts::MarkdownParserService).to receive(:call).with(
        comment.body
      ).and_return(formatted_content)

      decorator = described_class.decorate(comment)

      expect(decorator.body).to eq(formatted_content)
      expect(Posts::MarkdownParserService).to have_received(:call).with(
        comment.body
      ).once
    end
  end
end
