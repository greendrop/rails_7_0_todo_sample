# frozen_string_literal: true

class AdminLteFormBuilder
  module Label
    extend ActiveSupport::Concern

    def check_label(method, text = nil, options = {}, &)
      options = { class: 'form-check-label' }.merge(options)
      label(method, text, options, &)
    end

    def radio_label(method, text = nil, options = {}, &)
      check_label(method, text, options, &)
    end
  end
end
