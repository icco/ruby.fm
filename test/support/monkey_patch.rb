class ActionController::TestCase
  fixtures :all

  def teardown
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
end
