json.array!(@blobs) do |blob|
  json.extract! blob, :id, :location
  json.url blob_url(blob, format: :json)
end
