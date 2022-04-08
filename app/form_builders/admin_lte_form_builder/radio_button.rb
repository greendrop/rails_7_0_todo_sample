# frozen_string_literal: true

class AdminLteFormBuilder
  module RadioButton
    extend ActiveSupport::Concern
    include ActionView::Helpers::FormTagHelper

    def radio_button(method, tag_value, options = {})
      label_name = options.delete(:label_name)
      label_content = options.delete(:label_content)
      label_options = options.delete(:label_options)

      if label_content.present?
        label_options ||= {}
        label_options = {}.merge(label_options)
        label_tag label_name, label_options do
          super + label_content
        end
      else
        super
      end
    end
  end
end
