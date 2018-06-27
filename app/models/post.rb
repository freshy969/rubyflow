class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, markdown_link_presence: true
end
