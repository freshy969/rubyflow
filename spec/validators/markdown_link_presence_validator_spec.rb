require 'rails_helper'

class FakeMarkdownLinkPresenceValidatable
  include ActiveModel::Validations
  attr_accessor :content
  validates :content, markdown_link_presence: true
end

describe MarkdownLinkPresenceValidator do
  it 'does not set error if content contains one link' do
    validatable = FakeMarkdownLinkPresenceValidatable.new
    validatable.content = "This is a content with [link](http://google.com)"

    expect(validatable).to be_valid
  end

  it 'does not set error if content contains multiple links' do
    validatable = FakeMarkdownLinkPresenceValidatable.new
    validatable.content = "This is a [content](http://facebook.com) with [link](http://google.com)"

    expect(validatable).to be_valid
  end

  it 'sets error when content does not contain link' do
    validatable = FakeMarkdownLinkPresenceValidatable.new
    validatable.content = "This is a content without links"

    expect(validatable).not_to be_valid
    expect(validatable.errors[:content]).to eq(["contains no links"])
  end
end
