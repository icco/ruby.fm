Fabricator(:play) do
  episode { Fabricate(:episode) }
  bucket { Date.today }
end
