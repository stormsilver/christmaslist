module FormHelper
  def input_field_for(form, field_name, options = {}, &block)
    field_type = options.delete(:field_type) || :text_field
    label_text = ERB::Util.h(options.delete(:label_text) || field_name.to_s.humanize)
    options[:class] ||= 'form-control'
    field = options.delete(:field) || form.send(field_type, field_name, options)

    content_tag :div, :class => 'form-group' do
      out = form.label field_name, label_text, :class => 'col-sm-2 control-label'
      out += content_tag :div, :class => 'col-sm-6' do
        output = field
        output += ' '
        if block_given?
          output += capture(&block)
        end
        output
      end
      out
    end
  end

  def select_field_for(form, field_name, choices, options = {}, &block)
    options[:field_type] ||= :select
    include_blank = options.delete(:include_blank) || false
    disabled = options.delete(:disabled) || false

    prompt = options.delete(:prompt) || nil
    field_settings = { :include_blank => include_blank, :prompt => prompt }
    html_options = { :disabled => disabled, :class => options[:class] }
    options[:field] = form.send(options[:field_type], field_name, choices, field_settings, html_options)
    input_field_for form, field_name, options, &block
  end

  def collection_field_for(form, field_name, collection, value_method, text_method, options = {}, &block)
    options[:field_type] ||= :collection_select
    options[:field] = form.send(options[:field_type], field_name, collection, value_method, text_method, options, (options[:html] || {}))
    input_field_for form, field_name, options, &block
  end

  def form_actions &block
    content_tag :div, :class => 'form-group' do
      content_tag :div, :class => "col-sm-offset-2 col-sm-8 pull-right" do
        capture(&block)
      end
    end
  end
end
