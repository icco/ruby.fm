require 'pp'

# Environment
ENV['RAILS_ENV'] = 'test'
require 'dotenv'
Dotenv.overload('.env.test')

require File.expand_path('../../../config/environment', __FILE__)

# Rails
require 'rails/test_help'

# Minitest
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/spec'
require 'minitest/pride'

require 'mocha/mini_test'

# Local support files
require 'support/database_helpers'
require 'support/monkey_patch'
require 'support/fabricator'
