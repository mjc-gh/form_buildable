# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :body, :published_on, presence: true
  validate :must_be_published_in_future

  private

  def must_be_published_in_future
    errors.add :published_on, :in_future if published_on < Time.current
  end
end
