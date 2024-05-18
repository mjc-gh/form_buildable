# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"

require "form_buildable/version"
require "form_buildable/base"
require "form_buildable/options"
require "form_buildable/railtie"
require "form_buildable/factory"

module FormBuildable
  extend ActiveSupport::Concern

  def self.builder_classes
    @builder_classes ||= {}
  end

  class_methods do
    def define_form_builder(name, &block)
      # TODO reload this on active support reloading for better dev exp?
      # Create new FormBuilder subclass
      klass = FormBuildable.builder_classes[name.to_sym] = Factory.new(&block).build

      # Define form helper methods along with a helper method to retrieve the
      # builder class
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{name}_form_with(*args, **kwargs, &block)
          kwargs[:class] = FormBuildable.prepend_html_class(kwargs[:class], "#{klass.html_classes_for(:form)}")

          form_with *args, builder: #{name}_builder_class, **kwargs, &block
        end

        def #{name}_builder_class
          FormBuildable.builder_classes[:#{name}]
        end
      RUBY_EVAL
    end
  end

  def self.prepend_html_class(html_class, prepended)
    "#{prepended} #{html_class}".strip
  end
end
