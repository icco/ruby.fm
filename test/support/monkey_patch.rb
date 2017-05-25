class ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  include DatabaseHelpers

  Warden.test_mode!
  fixtures :all

  def teardown
    Warden.test_reset!
  end

  def options(action, *args)
    process(action, "OPTIONS", *args)
  end

  def assert_blank(obj, msg=nil)
    msg ||= "expected #{obj} to be blank, but wasn't"
    assert(obj.blank?, msg)
  end
end

class ActiveSupport::TestCase
  fixtures :all

  class << self
    alias :context :describe
  end
end
