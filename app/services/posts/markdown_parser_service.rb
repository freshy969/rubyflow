module Posts
  class MarkdownParserService
    def self.call(content)
      renderer = Redcarpet::Render::HTML.new(link_attributes: {target: "_blank"})
      markdown = Redcarpet::Markdown.new(renderer)
      markdown.render(content)
    end
  end
end
