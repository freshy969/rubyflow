require 'rails_helper'

describe Posts::MarkdownParserService do
  describe '.call' do
    it 'replaces markdown syntax with the HTML tags' do
      content = 'John **Doe** is the _president_ of the [United States](http://usa.com)'
      expectation = "<p>John <strong>Doe</strong> is the <em>president</em> of the <a href=\"http://usa.com\" target=\"_blank\">United States</a></p>\n"
      renderer = instance_double(Redcarpet::Render::HTML)
      markdown = instance_double(Redcarpet::Markdown, render: double)
      allow(Redcarpet::Render::HTML).to receive(:new).with(link_attributes: {target: "_blank"}).and_return(renderer)
      allow(Redcarpet::Markdown).to receive(:new).with(renderer).and_return(markdown)
      allow(markdown).to receive(:render).with(content).and_return(expectation)

      result = described_class.call(content)

      expect(result).to eq(expectation)
      expect(markdown).to have_received(:render).with(content).once
    end
  end
end
