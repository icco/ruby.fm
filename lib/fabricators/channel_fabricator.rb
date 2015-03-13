Fabricator(:channel) do
  title { sequence(:title) { |i| "Test #{i}" } }
  user_id { Fabricate(:user).id }
end
