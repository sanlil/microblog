require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
                password: "foobar", password_confirmation: "foobar")
  end

  test "valid login" do
    post login_path, params: { session: { email: "user@example.com", password: "foobar" } }
    assert_response :success
    assert response.body.present?

    resp = JSON.parse(response.body)
    current_user = User.find_by(auth_token: resp["user"]["auth_token"])
    @user.reload
    assert current_user.present?
    assert_not_nil current_user.auth_token
    assert_equal @user, current_user
  end

  test "invalid login" do
    post login_path, params: { session: { email: "user@example.com", password: "foo" } }
    assert_response :unprocessable_entity
    assert_not JSON.parse(response.body).present?
  end

  test "logout" do
    assert_not_nil @user.auth_token
    old_auth_token = @user.auth_token
    
    delete logout_path, headers: { "Authorization" => @user.auth_token }
    assert_response :no_content

    @user.reload
    assert_not_equal old_auth_token, @user.auth_token
  end

  test "invalid logout" do
    assert_not_nil @user.auth_token
    old_auth_token = @user.auth_token

    delete logout_path, headers: { "Authorization" => "" }
    assert_response :unauthorized

    @user.reload
    assert_equal old_auth_token, @user.auth_token
  end

end
