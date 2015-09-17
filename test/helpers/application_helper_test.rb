require 'test_helper'

class ApplicationHelperTest < Minitest::Test
  class Mock
    include ApplicationHelper
  end

  def setup
    @subject = Mock.new
  end

  def test_utf8_clean
    bad = %Q{바 20. Gabrielle Aplin - Please Don't Say You Love Me (Cyril Hahn Remix)}

    result = @subject.utf8_clean(bad)

    puts result

    assert(result.include?("ᄇ"), "expected ᄇ to still be present")
    assert(result.include?("ᅡ"), "expected ᅡ to still be present")
  end
end
