# frozen_string_literal: true

require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  test "form container has correct class" do
    get form_path(id: "post")

    assert_select "form.default-form"
  end

  test "standard text input fields" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Title field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_title']", text: "Title"
        assert_select "input.input[type='text'][name='post[title]'][id='post_title']"
      end

      # Body field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_body']", text: "Body"
        assert_select "textarea.input[name='post[body]'][id='post_body']"
      end
    end
  end

  test "datetime input fields" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Published on field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_published_on']", text: "Published on"
        assert_select "input.input[type='time'][name='post[published_on]'][id='post_published_on']"
      end

      # Draft date field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_draft_date']", text: "Draft date"
        assert_select "input.input[type='date'][name='post[draft_date]'][id='post_draft_date']"
      end
    end
  end

  test "typed input fields" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Author (email) field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_author']", text: "Author"
        assert_select "input.input[type='email'][name='post[author]'][id='post_author']"
      end

      # Ranking (number) field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_ranking']", text: "Ranking"
        assert_select "input.input[type='number'][name='post[ranking]'][id='post_ranking']"
      end

      # Canonical URL field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_canonical_url']", text: "Canonical url"
        assert_select "input.input[type='url'][name='post[canonical_url]'][id='post_canonical_url']"
      end

      # API key (password) field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_api_key']", text: "Api key"
        assert_select "input.input[type='password'][name='post[api_key]'][id='post_api_key']"
      end

      # Keywords (search) field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_keywords']", text: "Keywords"
        assert_select "input.input[type='search'][name='post[keywords]'][id='post_keywords']"
      end

      # Contact phone (tel) field
      assert_select "div.default-form-control" do
        assert_select "label[for='post_contact_phone']", text: "Contact phone"
        assert_select "input.input[type='tel'][name='post[contact_phone]'][id='post_contact_phone']"
      end
    end
  end

  test "checkbox field" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Checkbox is not wrapped by default (uses Rails checkbox method, not check_box override)
      assert_select "input[type='checkbox'][name='post[published]'][id='post_published'][value='1']"
    end
  end

  test "radio button fields" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # First radio button (draft)
      assert_select "input[type='radio'][name='post[status]'][id='post_status_draft'][value='draft']"

      # Second radio button (published)
      assert_select "input[type='radio'][name='post[status]'][id='post_status_published'][value='published']"
    end
  end

  test "select field" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Select field without wrapper (not wrapped by field helper)
      assert_select "select[name='post[category]'][id='post_category']" do
        assert_select "option[value='News']", text: "News"
        assert_select "option[value='Blog']", text: "Blog"
        assert_select "option[value='Tutorial']", text: "Tutorial"
      end
    end
  end

  test "submit button" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      # Submit renders as input[type=submit] (no btn class without explicit override)
      assert_select "input.submit[type='submit'][name='commit'][value='Submit Post']"
    end
  end

  test "button" do
    get form_path(id: "post")

    assert_select "form.default-form" do
      assert_select "button.btn[type='submit'][name='button']", text: "Create Post"
    end
  end
end
