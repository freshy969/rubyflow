require 'rails_helper'

describe PostDecorator do
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
