json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :activity_id, :student_id, :low_income, :committed, :payment_type
  json.url enrollment_url(enrollment, format: :json)
end
