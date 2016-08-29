require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @micropost1 = Micropost.create(user_id: @user.id, content: "lorem")
    @micropost2 = Micropost.create(user_id: @user.id, content: "ipsum")
  end

  test "list microposts" do
    get microposts_path + "/1", headers: {"Authorization" => @user.auth_token}
    assert_response :success
    
    posts = JSON.parse(response.body)["microposts"]
    assert 2, posts.length
    assert @micropost1.content, posts[0]["content"]
    assert @micropost2.content, posts[1]["content"]
  end

  test "list with incorrect user id" do
    get microposts_path + "/2", headers: {"Authorization" => @user.auth_token}
    assert_response :unprocessable_entity
  end

  test "create micropost" do
    post microposts_path, headers: {"Authorization" => @user.auth_token},
                          params: {"content" => "lorem", "user_id" => 1}
    assert_response :success

    post = JSON.parse(response.body)["micropost"]
    assert 3, post["id"]
    assert 3, Micropost.where(user_id: @user.id).length
  end

  test "create with content too long" do
    post microposts_path, headers: {"Authorization" => @user.auth_token},
                          params: {"content" => "a"*141}
    assert_response :unprocessable_entity
    assert 2, Micropost.all
  end

  test "create with invalid auth token" do
    post microposts_path, headers: {"Authorization" => ""},
                          params: {"content" => "lorem"}
    assert_response :unauthorized
    assert 2, Micropost.all
  end

end