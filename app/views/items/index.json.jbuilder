json.array!(@items) do |item|
  json.extract! item, :id, :name, :price, :amount, :comment, :order_id, :user_id
  json.url item_url(item, format: :json)
end
