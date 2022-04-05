class AdminLteFormBuilder
  module Submit
    extend ActiveSupport::Concern

    def submit(value = nil, options = {})
      options = {
        class: 'btn btn-primary'
      }.merge(options)
      super
    end
  end
end
