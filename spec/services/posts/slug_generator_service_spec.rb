require 'rails_helper'

describe Posts::SlugGeneratorService do
  describe '.call' do
    it 'generates slug for given post title' do
      title = 'A complete guide to build blog with Ruby'
      slug_id = 'rpNFb1'
      allow(SecureRandom).to receive(:urlsafe_base64).and_return(slug_id)

      result = described_class.call(title: title)

      expect(result).to eq("#{slug_id}-a-complete-guide-to-build-blog-with-ruby")
      expect(SecureRandom).to have_received(:urlsafe_base64).once
    end
  end
end
