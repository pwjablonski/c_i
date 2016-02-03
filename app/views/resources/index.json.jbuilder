json.array!(@resources) do |resource|
  json.extract! resource, :id, :string, :string, :string
  json.url resource_url(resource, format: :json)
end
