# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string   :title
      t.string   :author
      t.text     :body
      t.datetime :published_on
      t.text     :canonical_url
      t.integer  :ranking
      t.text     :api_key
      t.text     :keywords
      t.string   :contact_phone
      t.date     :draft_date

      t.boolean  :published, default: false
      t.string   :status
      t.string   :category

      t.timestamps
    end
  end
end
