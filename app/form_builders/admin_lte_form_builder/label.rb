class AdminLteFormBuilder
  module Label
    extend ActiveSupport::Concern

    def check_label(method, text = nil, options = {}, &block)
      options = { class: 'form-check-label' }.merge(options)
      label(method, text, options, &block)
    end

    def radio_label(method, text = nil, options = {}, &block)
      check_label(method, text, options, &block)
    end
  end
end
