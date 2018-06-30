require 'rails_helper'

describe Posts::ListQuery do
  describe '.call' do
    it 'returns posts' do
      post = create(:post)
      another_post = create(:post)

      expect(described_class.call).to eq([post, another_post])
    end

    it 'returns 5 last posts with given offset if the offset param is passed' do
      post_1 = Timecop.travel(5.minutes.ago) { create(:post) }
      post_2 = Timecop.travel(6.minutes.ago) { create(:post) }

      2.times { create(:post) }

      expect(described_class.call(offset: 2)).to eq([post_1, post_2])
    end
  end
end
