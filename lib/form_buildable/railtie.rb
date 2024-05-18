# frozen_string_literal: true

module FormBuildable
  class Railtie < ::Rails::Railtie
    config.to_prepare do
      FormBuildable.builder_classes.clear
    end
  end
end
