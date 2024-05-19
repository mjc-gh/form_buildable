# frozen_string_literal: true

module FormBuildable
  class Railtie < ::Rails::Railtie
    config.to_prepare do
      FormBuildable.builder_classes.clear
    end

    # Remove form error wrapping
    config.action_view.field_error_proc = proc { |html_tag, _instance| html_tag.html_safe }
  end
end
