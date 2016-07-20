json.array!(@walkathon_pledges) do |walkathon_pledge|
  json.extract! walkathon_pledge, :id, :sponsor_name, :sponsor_phone, :pledge_per_lap, :maximum_pledge, :fixed_pledge
  json.url walkathon_pledge_url(walkathon_pledge, format: :json)
end
