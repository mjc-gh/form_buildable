# frozen_string_literal: true

module FormBuildable
  class Base < ActionView::Helpers::FormBuilder
    def field(method, *args, label: true, **kwargs)
      has_error = @object&.errors&.key?(method)

      # TODO allow customization of the HTML for this field wrapper tag (or tags)
      @template.tag.div class: html_classes_for(:field) do
        # Add :class option to input builder call
        kwargs[:class] = prepend_html_class(kwargs[:class], html_classes_for(:input))

        if label
          if has_error
            label(method, label_text(label)) + yield(method, *args, **kwargs) + error_tag(method, id: field_id(method))
          else
            label(method, label_text(label)) + yield(method, *args, **kwargs)
          end
        else
          if has_error
            yield(method, *args, **kwargs) + error_tag(method, id: field_id(method))
          else
            yield(method, *args, **kwargs)
          end
        end
      end
    end

    def error_tag(method, id: nil)
      id ||= "#{@object.model_name.singular}_#{method}"

      # TODO allow customization of the HTML for this field wrapper tag (or tags)
      @template.tag.div class: html_classes_for(:error_container) do
        @template.tag.p class: html_classes_for(:error), 'aria-live': "polite", id: id, data: { error: id } do
          @object.errors.full_messages_for(method).join("\n")
        end
      end
    end

    def button(value = nil, options = {}, &block)
      options[:class] = prepend_html_class(options[:class], html_classes_for(:button))

      super value, options, &block
    end

    def check_box(method, options = {}, *args, &block)
      options[:class] = prepend_html_class(options[:class], html_classes_for(:check_box_input))

      cb_tag = @template.tag.div class: html_classes_for(:check_box) do
        super(method, options, *args) +
          label(method, nil, class: html_classes_for(:check_box_label), &block)
      end

      return cb_tag unless @object&.errors&.key?(method)

      cb_tag + error_tag(method, id: field_id(method))
    end

    def label(method, text = nil, options = {}, &block)
      options[:class] ||= html_classes_for(:label)

      super method, text, options, &block
    end

    def label_text(label)
      case label
      in true then nil
      in false then nil
      else label
      end
    end

    delegate :html_classes_for, to: :class
    delegate :prepend_html_class, to: "FormBuildable"
  end
end
