json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :service_id, :isadmin, :activecard
  json.url user_url(user, format: :json)
end
