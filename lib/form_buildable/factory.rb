# frozen_string_literal: true

module FormBuildable
  class Factory
    def initialize(&block)
      @block = block
    end

    def build
      new_buildable_class.tap do |klass|
        klass.instance_eval(&@block)
      end
    end

    private

    def new_buildable_class
      # Method methods text_field, email_field, etc.
      field_methods = instance_methods.select do |method|
        method.arity == -2 &&
          method.name =~ /_field|text_area\z/ &&
          !method.name.in?(%i[hidden_field])
      end

      Class.new(FormBuildable::Base) do
        extend Options

        cattr_reader :options, default: {}

        field_methods.each do |method|
          class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
            def #{method.name}(method, *, **)
              field(method, *, **) { |*args, **kwargs| super *args, **kwargs }
            end
          RUBY_EVAL
        end
      end
    end

    def instance_methods
      ActionView::Helpers::FormBuilder.instance_methods
        .map { |name| ActionView::Helpers::FormBuilder.instance_method name }
    end
  end
end
