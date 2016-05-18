json.array!(@orders) do |order|
  json.extract! order, :id, :type, :restaurant, :menu_image, :user_id
  json.url order_url(order, format: :json)
end
