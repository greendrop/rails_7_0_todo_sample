module FormHelper
  def error_message_on(record, attribute, options = {})
    errors = record.errors
    return unless errors.include?(attribute)
    messages = errors[attribute].map { |message| errors.full_message(attribute, message) }
    options = {
      partial: 'helpers/error_message_on',
      locals: { record: record, attribute: attribute, messages: messages }
    }.merge(options)
    render options
  end

  private

  module FormBuilder
    def error_message_on(method, options = {})
      @template.error_message_on(@object, method, options)
    end
  end

  ActionView::Helpers::FormBuilder.include FormBuilder
end
