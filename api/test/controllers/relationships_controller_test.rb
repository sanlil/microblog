require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = User.create(name: "First User", email: "user1@example.com",
                password: "foobar", password_confirmation: "foobar")
    @user2 = User.create(name: "Second User", email: "user2@example.com",
                password: "foobar", password_confirmation: "foobar")
  end

  test "create follow relationship" do
    assert_difference '@user1.following.count', 1 do
      post "/follow/" + @user2.id.to_s, headers: {"Authorization" => @user1.auth_token}
    end
    assert_response :success
  end

  test "create should require login" do
    assert_no_difference 'Relationship.count' do
      post "/follow/" + @user2.id.to_s, headers: {"Authorization" => ""}
    end
    assert_response :unauthorized
  end

  test "create with incorrect id" do
    incorrect_id = (@user2.id + 100).to_s
    assert_no_difference 'Relationship.count' do
      post "/follow/" + incorrect_id, headers: {"Authorization" => @user1.auth_token}
    end
    assert_response :unprocessable_entity
  end

  test "destroy follow relationship" do
    @user1.follow(@user2)
    assert_difference '@user1.following.count', -1 do
      delete "/unfollow/" + @user2.id.to_s, headers: {"Authorization" => @user1.auth_token}
    end
  end

  test "destroy should require login" do
    @user2.follow(@user1)
    assert_no_difference 'Relationship.count' do
      delete "/unfollow/" + @user2.id.to_s, headers: {"Authorization" => ""}
    end
    assert_response :unauthorized
  end

end