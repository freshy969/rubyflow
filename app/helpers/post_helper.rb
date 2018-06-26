module PostHelper
  def sanitize_post_content(content)
    sanitize(content, tags: %w(strong p a i em), attributes: %w(href target))
  end
end
