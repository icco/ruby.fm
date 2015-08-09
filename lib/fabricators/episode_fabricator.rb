Fabricator(:episode) do
  title { sequence(:title) { |i| "Test #{i}" } }
  channel { Fabricate(:channel) }
  length { 0 }
end
