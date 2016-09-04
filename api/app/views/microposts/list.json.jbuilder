json.microposts @microposts do |micropost|
  json.id micropost.id
  json.user_id micropost.user_id
  json.content micropost.content
  json.created_at micropost.created_at
  json.updated_at micropost.updated_at
end