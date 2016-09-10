require 'test_helper'

class FeedControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "First User", email: "user1@example.com",
                password: "foobar", password_confirmation: "foobar")
    @user2 = User.create(name: "Second User", email: "user2@example.com",
                password: "foobar", password_confirmation: "foobar")
    @micropost1 = @user.microposts.build(content: "lorem")
    @micropost2 = @user2.microposts.build(content: "ipsum")
  end

  test "show feed" do
    @user.save!
    @user2.save!
    @user.follow(@user2)

    get feed_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["feed"].present?
    assert_equal 2, JSON.parse(response.body)["feed"].length
  end

  test "show feed without following" do
    @user.save!

    get feed_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["feed"].present?
    assert_equal 1, JSON.parse(response.body)["feed"].length
  end

  test "do not show feed unauthorized" do
    @user.save!
    @user2.save!
    @user.follow(@user2)

    get feed_path, headers: { "Authorization" => "" }
    assert_response :unauthorized
    assert_not JSON.parse(response.body)["feed"].present?
  end

  test "micropost contains author" do
    @user.save!

    get feed_path, headers: { "Authorization" => @user.auth_token }
    assert_response :success

    assert response.body.present?
    assert JSON.parse(response.body)["feed"][0]["user"].present?
    assert_equal @user.id, JSON.parse(response.body)["feed"][0]["user"]["id"]
  end

end