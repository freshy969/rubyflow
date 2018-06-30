class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, markdown_link_presence: true

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  before_create :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = ::Posts::SlugGeneratorService.call(
      title: self.title
    )
  end
end
