json.array!(@tracks) do |track|
  json.extract! track, :id, :name, :github_repo_url
  json.url track_url(track, format: :json)
end
