require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    User.create(name: "Example User", email: "user@example.com",
                password: "foobar", password_confirmation: "foobar")
  end

  test "valid login" do
    post login_path, params: { session: { email: "user@example.com", password: "foobar" } }
    assert_response :success
    assert session[:user_id] == 1
    current_user ||= User.find_by(id: session[:user_id])
    assert_not current_user.nil?
  end

  test "invalid login" do
    post login_path, params: { session: { email: "user@example.com", password: "foo" } }
    assert session[:user_id].nil?
  end

  test "logout" do
    post login_path, params: { session: { email: "user@example.com", password: "foobar" } }
    assert_not session[:user_id].nil?
    delete logout_path
    assert_response :success
    assert session[:user_id].nil?
  end

end
