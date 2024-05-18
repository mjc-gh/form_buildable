# frozen_string_literal: true

require_relative "lib/form_buildable/version"

Gem::Specification.new do |spec|
  spec.name        = "form_buildable"
  spec.version     = FormBuildable::VERSION
  spec.authors     = ["Michael Coyne"]
  spec.email       = ["mjc@hey.com"]
  spec.homepage    = "https://github.com/mjc-gh/form_buildable-rails"
  spec.summary     = "Simple DSL for generating ActionView::Helpers::FormBuilder classes"
  spec.description = "Rails' FormBuilder from ActionView is very powerful on it's own. This adds a simple DSL to generate builder - it goes great with Tailwind!"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mjc-gh/form_buildable-rails"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.8"
end
