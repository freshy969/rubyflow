require 'rails_helper'

describe Posts::SlugGeneratorService do
  describe '.call' do
    it 'generates slug for given post title' do
      title = 'A complete guide to build blog with Ruby'

      result = Timecop.travel('Sat, 05 May 2018 00:00:00 +0000 ') do
        described_class.call(title: title)
      end

      expect(result).to eq("5ipe40rpiww-a-complete-guide-to-build-blog-with-ruby")
    end
  end
end
