Fabricator(:episode) do
  title { sequence(:title) { |i| "Test #{i}" } }
  channel_id { Fabricate(:channel).id }
  length { 0 }
end
