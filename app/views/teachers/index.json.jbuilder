json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :title, :first_name, :last_name, :room
  json.url teacher_url(teacher, format: :json)
end
