require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @micropost = Micropost.new(user_id: @user.id, content: "lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "must belong to user" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content must be present" do
    @micropost.content = nil
    assert_not @micropost.valid?
  end

  test "content must not be too long" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

end
