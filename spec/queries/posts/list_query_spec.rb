require 'rails_helper'

describe Posts::ListQuery do
  describe '.call' do
    it 'returns posts' do
      post = create(:post)
      another_post = create(:post)

      expect(described_class.call).to eq([post, another_post])
    end
  end
end
