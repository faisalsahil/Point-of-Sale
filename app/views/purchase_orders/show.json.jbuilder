json.array!(@order_products) do |order_product|
  json.extract! order_product, :id, :created_at
  json.url order_url(order_product, format: :json)
end
json.extract! @purchase_order, :id, :name, :created_at, :updated_at

