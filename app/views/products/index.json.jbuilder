json.array!(@products) do |product|
  json.extract! product, :name, :short_name, :price, :unit_id, :code, :category_id, :comments, :min_stock, :max_stick, :bar_code
  json.url product_url(product, format: :json)
end
