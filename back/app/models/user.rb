# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                                         | Type               | Attributes
# -------------------------------------------- | ------------------ | ---------------------------
# **`id`**                                     | `bigint`           | `not null, primary key`
# **`avatar`**                                 | `string`           |
# **`email`**                                  | `string`           | `not null`
# **`name`**                                   | `string`           |
# **`provider`**                               | `string`           |
# **`receive_notifications_expiration_date`**  | `boolean`          | `default(FALSE)`
# **`receive_notifications_weather`**          | `boolean`          | `default(FALSE)`
# **`uid`**                                    | `string`           |
# **`created_at`**                             | `datetime`         | `not null`
# **`updated_at`**                             | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_provider_and_uid` (_unique_):
#     * **`provider`**
#     * **`uid`**
#
class User < ApplicationRecord
  has_one :profile
  has_many :favorite_cosmetics
  has_many :cosmetic_usages, dependent: :destroy
  has_many :reviews

  validates :uid, uniqueness: { scope: :provider }
end
