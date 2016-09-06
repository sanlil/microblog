json.user do
  json.id @user.id
  json.auth_token @user.auth_token if @login or @user == @current_user
  json.name @user.name
  json.email @user.email
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.img gravatar_for(@user, 90)
  json.microposts @user.microposts
  json.micropost_count @user.microposts.count
  json.following @user.following
  json.followers @user.followers
  json.following_count @user.following.count
  json.followers_count @user.followers.count
end