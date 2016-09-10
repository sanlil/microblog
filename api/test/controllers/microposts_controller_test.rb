require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @micropost1 = @user.microposts.build(content: "lorem")
    @micropost2 = @user.microposts.build(content: "ipsum")
    @user.save!
  end

  test "list microposts" do
    get microposts_path + "/" + @user.id.to_s, headers: {"Authorization" => @user.auth_token}
    assert_response :success
    
    posts = JSON.parse(response.body)["microposts"]
    assert_equal 2, posts.length
    assert @micropost1.content, posts[0]["content"]
    assert @micropost2.content, posts[1]["content"]
  end

  test "list with incorrect user id" do
    incorrect_user_id = (@user.id+1).to_s
    get microposts_path + "/" + incorrect_user_id, headers: {"Authorization" => @user.auth_token}
    assert_response :unprocessable_entity
  end

  test "create micropost" do
    assert_difference 'Micropost.count', 1 do
      post microposts_path, headers: {"Authorization" => @user.auth_token},
                            params: {"micropost" => {"content" => "lorem"}}
    end
    assert_response :success
    assert_equal @user.id, JSON.parse(response.body)["micropost"]["user_id"]
  end

  test "create with content too long" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, headers: {"Authorization" => @user.auth_token},
                            params: {"micropost" => {"content" => "a"*141}}
    end
    assert_response :unprocessable_entity
  end

  test "create with invalid auth token" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, headers: {"Authorization" => ""},
                            params: {"content" => "lorem"}
    end
    assert_response :unauthorized
  end

  test "should delete micropost" do
    assert_difference 'Micropost.count', -1 do
      delete microposts_path + "/" + @micropost1.id.to_s, headers: {"Authorization" => @user.auth_token}
    end
    assert_response :success
  end

  test "should not delete others micropost" do
    @user2 = User.create(name: "User2", email: "user2@example.com",
                      password: "foobar", password_confirmation: "foobar")
    assert_no_difference 'Micropost.count' do
      delete microposts_path + "/" + @micropost1.id.to_s, headers: {"Authorization" => @user2.auth_token}
    end
    assert_response :unauthorized
  end

  test "should return unprocessable entity" do
    invalid_micropost_id = (@micropost1.id + 100).to_s
    assert_no_difference 'Micropost.count' do
      delete microposts_path + "/" + invalid_micropost_id, headers: {"Authorization" => @user.auth_token}
    end
    assert_response :unprocessable_entity
  end

end