require 'rails_helper'

describe Posts::RSSQuery do
  describe '.call' do
    it 'returns last 10 posts' do
      old_post = Timecop.travel(1.day.ago) { create(:post) }
      10.times { create(:post) }

      result = described_class.call

      expect(result.size).to eq(10)
      expect(result).not_to include(old_post)
    end
  end
end
