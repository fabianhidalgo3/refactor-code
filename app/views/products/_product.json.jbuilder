json.extract! product, :id, :name, :sell_in, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
