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

    assert_equal 2, users.length
    assert "First User", users[0]["name"]
    assert "Second User", users[1]["name"]
  end

  test "anauthorized request" do
    get users_path, headers: { "Authorization" => "" }
    assert_response :unauthorized
    assert_not JSON.parse(response.body)["users"].present?
  end

  test "show user" do
    @user2.microposts.build(content: "Lorem ipsum")
    @user2.save!

    get users_path + "/" + @user2.id.to_s, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["user"].present?
    assert_equal @user2.id, JSON.parse(response.body)["user"]["id"]
    assert JSON.parse(response.body)["user"]["microposts"].present?
    assert_equal 1, JSON.parse(response.body)["user"]["microposts"].length
    assert_not JSON.parse(response.body)["user"]["auth_token"].present?
  end

  test "show current user" do
    get user_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["user"].present?
    assert_equal @user.id, JSON.parse(response.body)["user"]["id"]
    assert JSON.parse(response.body)["user"]["auth_token"].present?
  end

  test "create new user" do
    post users_path, params: { user: { 
                name: "Third User", email: "user3@example.com",
                password: "foobar", password_confirmation: "foobar"}}
    assert_response :success
    assert_equal 3, User.count
    assert JSON.parse(response.body)["user"]["auth_token"].present?
  end

end