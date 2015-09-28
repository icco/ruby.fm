require 'test_helper'

class SignupRequestTest < ActionDispatch::IntegrationTest
  def test_error_on_signup_missing_params
    user_count = User.all.count
    post('/users', {}, {})

    assert_equal(400, @response.status)
    assert_equal(user_count, User.all.count)
  end

  def test_signup_success
    user_count = User.all.count
    params = {
      signup: {
        email: 'john@example.com',
        password: 'passwordington',
        full_name: 'John Doe',
        channel_name: 'The Missing Man'
      }
    }

    post('/users', params, {})

    assert_equal(302, @response.status)
    assert_equal(user_count + 1, User.all.count)
  end
end
