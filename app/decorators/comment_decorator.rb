class CommentDecorator < Draper::Decorator
  delegate_all

  def body
    ::Posts::MarkdownParserService.call(model.body)
  end

  def created_at
    ::Posts::DateManipulationService.call(model.created_at)
  end
end
