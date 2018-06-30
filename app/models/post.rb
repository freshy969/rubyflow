class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, markdown_link_presence: true

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
end
