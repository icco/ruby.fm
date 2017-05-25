Fabricator(:channel) do
  title { sequence(:title) { |i| "Test #{i}" } }
  user { Fabricate(:user) }
end
