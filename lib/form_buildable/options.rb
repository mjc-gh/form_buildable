# frozen_string_literal: true

module FormBuildable
  module Options
    %w[
      button_html_class
      check_box_html_class
      check_box_input_html_class
      check_box_label_html_class
      error_container_html_class
      error_html_class
      field_html_class
      form_html_class
      input_html_class
      label_html_class
      select_html_class
    ].each do |method|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{method}(&block)
          options[:#{method}] = block
        end
      RUBY_EVAL
    end

    # TODO add html_class to call block with
    def html_classes_for(type)
      options[:"#{type}_html_class"]&.call
    end
  end
end
