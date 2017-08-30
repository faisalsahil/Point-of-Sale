json.array!(@orders) do |order|
  json.extract! order, :id, :order_number, :order_date, :order_type, :location_id
  json.url order_url(order, format: :json)
end
