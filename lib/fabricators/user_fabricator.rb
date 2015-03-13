Fabricator(:user) do
  email { sequence(:email) { |i| "test-#{i}@example.com" } }
  password { "password" }
end
