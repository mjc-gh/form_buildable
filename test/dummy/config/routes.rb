# frozen_string_literal: true

Rails.application.routes.draw do
  get "posts/new"
  get "/basic" => "examples#basic"
end
