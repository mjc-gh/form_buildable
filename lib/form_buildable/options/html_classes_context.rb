# frozen_string_literal: true

module FormBuildable
  module Options
    class HtmlClassesContext
      def initialize(options)
        @options = options
      end

      %w[
        button
        check_box
        check_box_input
        check_box_label
        error_container
        error
        field
        form
        input
        label
        select
      ].each do |method|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{method}(&block)
            @options[:#{method}_html_class] = block
          end
        RUBY_EVAL
      end
    end
  end
end
