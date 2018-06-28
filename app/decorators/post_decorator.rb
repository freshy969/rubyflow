class PostDecorator < Draper::Decorator
  delegate_all

  def created_at
    ::Posts::DateManipulationService.call(model.created_at)
  end

  def content
    ::Posts::MarkdownParserService.call(model.content)
  end

  def editable?
    ::Posts::UserPolicy.editable?(
      post: model, user: context[:current_user]
    )
  end
end
