class PostDecorator < Draper::Decorator
  delegate_all

  def created_at
    ::Posts::DateManipulationService.call(model.created_at)
  end
end
