json.array!(@projects) do |project|
  json.extract! project, :id, :name, :tag_line, :description, :image_url, :student_id
  json.url project_url(project, format: :json)
end
