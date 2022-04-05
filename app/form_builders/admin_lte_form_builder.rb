class AdminLteFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  include CheckBox
  include EmailField
  include Label
  include NumberField
  include PasswordField
  include RadioButton
  include Select
  include Submit
  include TextArea
  include TextField

  def form_group(method, options = {}, &block)
    error_attributes = options.delete(:error_attributes) || []
    error_attributes << method
    classes = ['form-group']
    error_attributes.each do |attribute|
      classes << 'has-error' if @object.errors.include?(attribute)
    end
    options = {
      class: classes.join(' ')
    }.merge(options)
    @template.content_tag(:div, nil, options, &block)
  end

  private

  def error_attribute(method, error_options)
    error_options.delete(:attribute) || method
  end

  def field_name(method)
    "#{@object_name}[#{method}]"
  end
end
