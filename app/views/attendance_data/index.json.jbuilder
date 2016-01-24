json.array!(@attendance_data) do |attendance_datum|
  json.extract! attendance_datum, :id, :enrollment_id, :date, :present
  json.url attendance_datum_url(attendance_datum, format: :json)
end
