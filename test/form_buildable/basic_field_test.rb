require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  test "get post form" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      assert_select "div.default-form-control"
    end
  end
end
