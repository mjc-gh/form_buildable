# frozen_string_literal: true

module FormBuildable
  module Options
    def html_classes(&block)
      HtmlClassesContext.new(options).instance_eval(&block)
    end

    # TODO add html_class to call block with
    def html_classes_for(type)
      options[:"#{type}_html_class"]&.call
    end
  end
end
