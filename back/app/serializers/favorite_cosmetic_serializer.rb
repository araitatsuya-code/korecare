class FavoriteCosmeticSerializer < ActiveModel::Serializer
  attributes :user_id, :name, :brand, :price, :item_url, :image_url, :item_code
end