json.array!(@parents) do |parent|
  json.extract! parent, :id, :first_name, :last_name, :email, :phone_number, :role
  json.url parent_url(parent, format: :json)
end
