# frozen_string_literal: true

class AdminLteFormBuilder
  module TextArea
    extend ActiveSupport::Concern

    def text_area(method, options = {})
      options = {
        class: 'form-control',
        error_options: {}
      }.merge(options)
      error_options = options.delete(:error_options)
      super + error_message_on(error_attribute(method, error_options), error_options)
    end
  end
end
