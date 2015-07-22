json.array!(@registrations) do |registration|
  json.extract! registration, :id, :activity_id, :student_id, :low_income, :committed, :paid
  json.url registration_url(registration, format: :json)
end
