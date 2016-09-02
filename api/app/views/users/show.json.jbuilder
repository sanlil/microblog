json.user do
  json.id @user.id
  json.auth_token @user.auth_token if @login or @user == @current_user
  json.name @user.name
  json.email @user.email
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.img gravatar_for(@user, 90)
  json.microposts @microposts
end