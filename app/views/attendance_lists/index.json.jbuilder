json.array!(@attendance_lists) do |attendance_list|
  json.extract! attendance_list, :id, :classroom_id, :date
  json.url attendance_list_url(attendance_list, format: :json)
end
