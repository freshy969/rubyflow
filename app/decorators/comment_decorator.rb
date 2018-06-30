class CommentDecorator < Draper::Decorator
  delegate_all

  def body
    ::Posts::MarkdownParserService.call(model.body)
  end

end
