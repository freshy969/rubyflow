require 'rails_helper'

describe Users::FindPostQuery do
  describe '.call' do
    it 'returns user post' do
      user = create(:user, 
        provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url'
      )
      post = create(:post, user: user)

      expect(described_class.call(
        user: user, post_id: post.id
      )).to eq(post)
    end

    it 'raises ActiveRecord::RecordNotFound if there is not post with given id for given user' do
      user = create(:user, 
        provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url'
      )
      post = create(:post)

      expect { described_class.call(
        user: user, post_id: post.id
      ) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
