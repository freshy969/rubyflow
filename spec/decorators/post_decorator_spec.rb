require 'rails_helper'

describe PostDecorator do
  describe '#editable?' do
    it 'returns the result of UserPolicy#editable? call' do
      post = instance_double(Post)
      user = instance_double(User)
      allow(Posts::UserPolicy).to receive(:editable?).with(
        post: post, user: user
      ).and_return(true)

      decorator = described_class.decorate(post, context: { current_user: user })
      result = decorator.editable?

      expect(result).to eq(true)
      expect(Posts::UserPolicy).to have_received(:editable?).with(
        post: post, user: user
      ).once
    end
  end

  describe '#content' do
    it 'returns formatted content' do
      post = instance_double(Post, content: 'content')
      formatted_content = 'formatted content'
      allow(Posts::MarkdownParserService).to receive(:call).with(
        post.content
      ).and_return(formatted_content)

      decorator = described_class.decorate(post)

      expect(decorator.content).to eq(formatted_content)
      expect(Posts::MarkdownParserService).to have_received(:call).with(
        post.content
      ).once
    end
  end

  describe '#created_at' do
    it 'returns formatted creation date' do
      post = instance_double(Post, created_at: Date.parse('05/05/2018'))
      allow(Posts::DateManipulationService).to receive(:call).with(
        post.created_at
      ).and_return('5 MAY 2018')

      decorator = described_class.decorate(post)

      expect(decorator.created_at).to eq('5 MAY 2018')
      expect(Posts::DateManipulationService).to have_received(:call).with(
        post.created_at
      ).once
    end
  end
end
