require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "must belong to user" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content must be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "content must not be too long" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  test "order should be least recent last" do
    assert_equal microposts(:tau_manifesto), Micropost.last
  end

end
