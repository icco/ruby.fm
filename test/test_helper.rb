require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha/mini_test'
require 'webmock/minitest'

require_relative "./support/monkey_patch"
