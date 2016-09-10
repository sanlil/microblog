json.feed @feed do |micropost|
  json.id micropost.id
  json.content micropost.content
  json.created_at micropost.created_at
  json.updated_at micropost.updated_at
  json.user do
    json.id micropost.user.id
    json.name micropost.user.name
    json.img micropost.user.gravatar(65)
  end
end