json.array!(@users) do |user|
  json.extract! user, :id, :name, :username, :password_digest
  json.url user_url(user, format: :json)
end
