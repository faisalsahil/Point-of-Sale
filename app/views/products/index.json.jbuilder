json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :product_image, :avg_purchase_price, :sale_price, :purchase_margin, :sale_discount_percent, :sale_discount_flat, :is_sale_discount, :is_purchase_margin, :product_description, :product_nature_id, :product_category_id, :product_company_id, :product_brand_id, :product_unit_id, :product_type_id
  json.url product_url(product, format: :json)
end
