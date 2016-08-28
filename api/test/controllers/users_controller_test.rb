require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "First User", email: "user1@example.com",
                password: "foobar", password_confirmation: "foobar")
    @user2 = User.create(name: "Second User", email: "user2@example.com",
                password: "foobar", password_confirmation: "foobar")
  end

  test "list users" do
    get users_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success
    users = JSON.parse(response.body)["users"]

    assert 2, users.length
    assert "First User", users[0]["name"]
    assert "Second User", users[1]["name"]
  end

  test "anauthorized request" do
    get users_path, headers: { "Authorization" => "" }
    assert_response :unauthorized
    assert_not JSON.parse(response.body)["users"].present?
  end

  test "show user" do
    get users_path + "/2", headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["user"].present?
    assert 2, JSON.parse(response.body)["user"]["id"]
    assert_not JSON.parse(response.body)["user"]["auth_token"].present?
  end

  test "show current user" do
    get user_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["user"].present?
    assert 1, JSON.parse(response.body)["user"]["id"]
    assert JSON.parse(response.body)["user"]["auth_token"].present?
  end

  test "create new user" do
    post users_path, params: { user: { 
                name: "Third User", email: "user3@example.com",
                password: "foobar", password_confirmation: "foobar"}}
    assert_response :success
    assert 3, JSON.parse(response.body)["user"]["id"]
    assert JSON.parse(response.body)["user"]["auth_token"].present?
  end


end