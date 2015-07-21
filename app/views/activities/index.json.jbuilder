json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :instructor, :description, :start, :end, :times, :seats, :visible, :lakewood_eligibility_date
  json.url activity_url(activity, format: :json)
end
