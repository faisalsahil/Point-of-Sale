json.array!(@purchase_order_products) do |purchase_order_product|
  json.extract! purchase_order_product, :id, :purchase_order_id, :current_stock, :purchase_quantity
  json.url purchase_order_product_url(purchase_order_product, format: :json)
end
