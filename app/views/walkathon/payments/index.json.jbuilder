json.array!(@walkathon_payments) do |walkathon_payment|
  json.extract! walkathon_payment, :id, :description, :amount, :walkathon_pledge_id
  json.url walkathon_payment_url(walkathon_payment, format: :json)
end
