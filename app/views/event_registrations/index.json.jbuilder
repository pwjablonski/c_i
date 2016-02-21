json.array!(@event_registrations) do |event_registration|
  json.extract! event_registration, :id, :event_id, :eb_event_id, :eb_attendee_id, :student_id
  json.url event_registration_url(event_registration, format: :json)
end
