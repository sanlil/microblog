json.micropost do
  json.content @micropost.content
  json.user_id @micropost.user_id
  json.created_at @micropost.created_at
  json.updated_at @micropost.updated_at
end