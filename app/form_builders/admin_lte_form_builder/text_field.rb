class AdminLteFormBuilder
  module TextField
    extend ActiveSupport::Concern

    def text_field(method, options = {})
      options = {
        class: 'form-control',
        error_options: {}
      }.merge(options)
      error_options = options.delete(:error_options)
      super + error_message_on(error_attribute(method, error_options), error_options)
    end
  end
end
