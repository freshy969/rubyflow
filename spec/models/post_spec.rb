require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'slug generation' do
    it 'generates new slug during the post creation' do
      post = build(:post, title: 'Ruby on Rails tutorial')

      Timecop.travel('Sat, 05 May 2018 00:00:00 +0000 ') do
        post.save
      end

      expect(post.slug).to eq('5ipe40rpiwx-ruby-on-rails-tutorial')
    end

    it 'does not generate slug when post data is invalid' do
      post = build(:post, title: nil)

      post.save

      expect(post.slug).to eq(nil)
    end
  end
end
