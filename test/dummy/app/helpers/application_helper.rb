# frozen_string_literal: true

module ApplicationHelper
  include FormBuildable

  define_form_builder :default do
    html_classes do
      button { "btn" }

      form { "default-form" }
      field { "default-form-control" }

      check_box_input { "check-box-input" }
      check_box { "check-box" }
      check_box_label { "check-box-label" }

      input { "input" }

      error_container { "error-container" }
      error { "error" }
    end
  end
end
