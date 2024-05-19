# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :body, :published_on, presence: true
  validates :author, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :must_be_published_in_future

  private

  def must_be_published_in_future
    return unless published_on

    errors.add :published_on, :in_future if published_on < Time.current
  end
end
