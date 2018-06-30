require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'slug generation' do
    it 'generates new slug during the post creation' do
      post = build(:post, title: 'Ruby on Rails tutorial')
      slug_id = 'rpNFb1'
      allow(SecureRandom).to receive(:urlsafe_base64).and_return(slug_id)

      post.save

      expect(post.slug).to eq('rpNFb1-ruby-on-rails-tutorial')
      expect(SecureRandom).to have_received(:urlsafe_base64).once
    end

    it 'does not generate slug when post data is invalid' do
      post = build(:post, title: nil)

      post.save

      expect(post.slug).to eq(nil)
    end
  end
end
