json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :instructor, :description, :start, :end, :times, :seats, :visible
  json.url activity_url(activity, format: :json)
end
