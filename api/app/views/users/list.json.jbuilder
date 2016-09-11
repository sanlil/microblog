json.users @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.created_at user.created_at
  json.updated_at user.updated_at
  json.img user.gravatar(70)
  json.micropost_count user.microposts.count
  json.following_count user.following.count
  json.followers_count user.followers.count
end