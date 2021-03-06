require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @other_user = User.new(name: "Another User", email: "user2@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save!
    assert_not duplicate_user.valid?
  end

  test "email addresses should be unique, despite different casing" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save!
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save!
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should be nonblank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "user has attribute auth_token" do
    assert @user.has_attribute?(:auth_token)
  end

  test "authentication token is unique" do
    @user.save!
    assert @user.valid?

    @other_user.auth_token = @user.auth_token
    assert_not @other_user.valid?
  end

  test "should generate authentication token" do
    @user.generate_authentication_token
    assert @user.auth_token.present?
  end

  test "should generate authentication token on save" do
    @user.save!
    assert @user.auth_token.present?
  end

  test "should generate unique authentication token" do
    @user.save!
    @other_user.save!
    assert @user.auth_token.present?
    assert @other_user.auth_token.present?
    assert_not_equal @user.auth_token, @other_user.auth_token
  end

  test "can save to database" do
    assert_nil @user.id
    @user.save!
    @user.reload
    assert @user.valid?
  end

  test "associated microposts should be destroyed" do
    @user.save!
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    @user.save!
    @other_user.save!
    assert_not @user.following?(@other_user)
    @user.follow(@other_user)
    assert @user.following?(@other_user)
    assert @other_user.followers.include?(@user)
    @user.unfollow(@other_user)
    assert_not @user.following?(@other_user)
  end

  test "cannot follow same twice" do
    @user.save!
    @other_user.save!
    assert_difference '@user.following.count', 1 do
      @user.follow(@other_user)
    end
    assert_no_difference '@user.following.count' do
      @user.follow(@other_user)
    end
  end

  test "feed should have posts" do
    @user.save!
    @other_user.save!
    @user.follow(@other_user)

    # Posts from followed user
    @other_user.microposts.each do |post_following|
      assert @user.feed.include?(post_following)
    end
    # Posts from self
    @user.microposts.each do |post_self|
      assert @user.feed.include?(post_self)
    end
  end

  test "feed should not have posts" do
    @user.save!
    @other_user.save!

    # Posts from unfollowed user
    @other_user.microposts.each do |post_unfollowed|
      assert_not @user.feed.include?(post_unfollowed)
    end
  end

end
