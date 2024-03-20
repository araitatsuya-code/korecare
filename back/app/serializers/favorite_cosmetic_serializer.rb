# ## Schema Information
#
# Table name: `favorite_cosmetics`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`brand`**       | `string`           |
# **`image_url`**   | `string`           |
# **`item_code`**   | `string`           |
# **`item_url`**    | `string`           |
# **`name`**        | `string`           |
# **`price`**       | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`user_id`**     | `bigint`           |
#
# ### Indexes
#
# * `index_favorite_cosmetics_on_user_id`:
#     * **`user_id`**
# * `index_favorite_cosmetics_on_user_id_and_item_code` (_unique_):
#     * **`user_id`**
#     * **`item_code`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
class FavoriteCosmeticSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :brand, :price, :item_url, :image_url, :item_code
end
