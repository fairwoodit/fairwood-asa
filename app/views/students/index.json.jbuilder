json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :parent_id, :grade, :teacher_name
  json.url student_url(student, format: :json)
end
