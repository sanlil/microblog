json.user do
  json.id @current_user.id
  json.name @current_user.name
  json.email @current_user.email
  json.created_at @current_user.created_at
  json.updated_at @current_user.updated_at
end