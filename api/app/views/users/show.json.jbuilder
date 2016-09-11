json.user do
  json.id @user.id
  json.auth_token @user.auth_token if @login or @user == @current_user
  json.name @user.name
  json.email @user.email
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.img @user.gravatar(100)
  json.microposts @user.microposts
  json.micropost_count @user.microposts.count
  json.following @user.following do |following|
    json.id following.id
    json.name following.name
    json.email following.email
    json.img following.gravatar(70)
    json.micropost_count following.microposts.count
  end
  json.followers @user.followers do |follower|
    json.id follower.id
    json.name follower.name
    json.email follower.email
    json.img follower.gravatar(70)
    json.micropost_count follower.microposts.count
  end
  json.following_count @user.following.count
  json.followers_count @user.followers.count
end