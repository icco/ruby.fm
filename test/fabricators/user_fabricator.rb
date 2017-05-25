Fabricator(:user) do
  email { sequence(:email) { |i| "test-#{i}@example.com" } }
  password "password"
  password_confirmation "password"
end
