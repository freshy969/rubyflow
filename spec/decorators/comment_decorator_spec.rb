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

  describe '#created_at' do
    it 'returns formatted creation date' do
      comment = instance_double(Comment, created_at: Date.parse('05/05/2018'))
      allow(Posts::DateManipulationService).to receive(:call).with(
        comment.created_at
      ).and_return('5 MAY 2018')

      decorator = described_class.decorate(comment)

      expect(decorator.created_at).to eq('5 MAY 2018')
      expect(Posts::DateManipulationService).to have_received(:call).with(
        comment.created_at
      ).once
    end
  end
end
