# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string   :title
      t.string   :author
      t.text     :body
      t.datetime :published_on

      t.timestamps
    end
  end
end
