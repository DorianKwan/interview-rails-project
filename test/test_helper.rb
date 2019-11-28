ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "minitest/focus"

# Consider setting MT_NO_EXPECTATIONS to not add expectations to Object.
# ENV["MT_NO_EXPECTATIONS"] = true

# Enable SQL query logging
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# Set up database cleaner to wrap tests in transactions.
# Transactions will be rolled back after every test
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

# Load modules into Minitest base class
class Minitest::Test

  # Set up database cleaner callbacks
  def before_setup
    DatabaseCleaner.start
    super
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end

end

