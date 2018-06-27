class MarkdownLinkPresenceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value.to_s.match(/\[.*\]\((http|https).*\)/).blank?
      record.errors.add(attribute, 'contains no links')
    end
  end

end
