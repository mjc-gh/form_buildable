# FormBuildable

[![FormBuildable](https://github.com/mjc-gh/form_buildable/actions/workflows/actions.yml/badge.svg)](https://github.com/mjc-gh/form_buildable/actions/workflows/actions.yml)

Declaratively build
[FormBuilder](https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html)
classes in Rails. Goes great with TailwindCSS!

## Usage

```ruby
module ApplicationHelper
  include FormBuildable

  define_form_builder :default do
    html_classes do
      button {
        "inline-flex items-center justify-center rounded border shadow-sm font-medium px-4 py-2 text-sm "\
        " border-transparent text-white bg-blue-600 md:text-base lg:text-lg hover:bg-blue-800 "
      }

      form { "space-y-4" }
      field { "flex flex-col gap-2" }

      check_box_input { "w-6 h-6 text-blue-600 bg-gray-100 border-gray-300 rounded" }
      check_box { "flex gap-2 items-center" }
      check_box_label { "text-md" }

      input { "rounded-lg border-slate-300 p-2 text-slate-900 " }

      error_container { "flex justify-start" }
      error { "text-sm text-red-700 font-bold whitespace-pre" }
    end
  end

  define_form_builder :inline do
    # some other classes...
  end
end
```

Now use in a view with `default_form_with` or `default_form_for`

```erb
<%= default_form_with model: @user, url: registrations_path do |form| -%>
  <%= form.email_field :email -%>
  <%= form.check_box :accepted_terms -%>
  <%= form.button -%>
<% end -%>
```

Will produce some HTML like:

```html
<form class="space-y-4" action="/users/registrations" method="post">
  <div class="flex flex-col gap-2">
    <label for="email_email">Email</label>
    <input class="rounded-lg border-slate-300 p-2 text-slate-900" type="email" name="email[email]" id="email_email" />
  </div>
  <div class="flex gap-2 items-center">
    <input name="email[accepted_terms]" type="hidden" value="0" autocomplete="off" />
    <input class="w-6 h-6 text-blue-600 bg-gray-100 border-gray-300 rounded" type="checkbox" value="1" name="email[accepted_terms]" id="email_accepted_terms" />
    <label class="text-md" for="email_accepted_terms">Accepted terms</label>
  </div>
  <button name="button" type="submit" class="inline-flex items-center justify-center rounded border shadow-sm font-medium px-4 py-2 text-sm border-transparent text-white bg-blue-600 md:text-base lg:text-lg hover:bg-blue-800">
    Create User
  </button
</form>
```

And when there is an error, the model's errors are automatically added
to the markup

```html
<form class="space-y-4" action="/registrations" method="post">
  <div class="flex flex-col gap-2">
    <label for="email_address">Address</label><input class="rounded-lg border-slate-300 p-2 text-slate-900" type="email" value="" name="email[address]" id="email_address" />
    <div class="flex justify-start"><p class="text-sm text-red-700 font-bold whitespace-pre" aria-live="polite" id="email-address-error" data-error="email-address-error">Address is invalid</p></div>
  </div>
  <div class="flex gap-2 items-center">
    <input name="email[accepted_terms]" type="hidden" value="0" autocomplete="off" />
    <input class="w-6 h-6 text-blue-600 bg-gray-100 border-gray-300 rounded" type="checkbox" value="1" name="email[accepted_terms]" id="email_accepted_terms" /><label class="text-md" for="email_accepted_terms">Accepted terms</label>
  </div>
  <div class="flex justify-start"><p class="text-sm text-red-700 font-bold whitespace-pre" aria-live="polite" id="email-accepted_terms-error" data-error="email-accepted_terms-error">Accepted terms must be accepted</p></div>
  <button name="button" type="submit" class="inline-flex items-center justify-center rounded border shadow-sm font-medium px-4 py-2 text-sm border-transparent text-white bg-blue-600 md:text-base lg:text-lg hover:bg-blue-800">
    Create Email
  </button>
</form>
```

## TODO

So much! Maybe?

- Radio buttons, selects, and other fields
- Customize HTML of wrapper methods
- Customize error and label HTML placement with the inputs
- Form hints, placeholders, and more I18n customizations
- Document other new form builder methods like `error_tag` and `field`

## Installation
Add this line to your application's Gemfile:

```ruby
gem "form_buildable"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install form_buildable
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
