json.array!(@notifications) do |notification|
  json.extract! notification, :id, :title, :message, :date_posted
  json.url notification_url(notification, format: :json)
end
