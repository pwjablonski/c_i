json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :message, :classroom_id, :subject
  json.url announcement_url(announcement, format: :json)
end
