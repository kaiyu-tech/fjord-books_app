# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user, password: 'password')
    visit root_url
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: password
    click_on 'ログイン'
  end

  def log_out
    click_on 'ログアウト'
  end
end
