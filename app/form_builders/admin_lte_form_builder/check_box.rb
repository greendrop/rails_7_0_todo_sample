# frozen_string_literal: true

class AdminLteFormBuilder
  module CheckBox
    extend ActiveSupport::Concern

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      options = { class: 'form-check-input' }.merge(options)
      super
    end
  end
end
