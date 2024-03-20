# ## Schema Information
#
# Table name: `profiles`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `bigint`           | `not null, primary key`
# **`age`**           | `integer`          |
# **`avatar`**        | `string`           |
# **`name`**          | `string`           |
# **`prefecture`**    | `string`           |
# **`skin_trouble`**  | `string`           |
# **`skin_type`**     | `string`           |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`address_id`**    | `bigint`           |
# **`user_id`**       | `bigint`           |
#
# ### Indexes
#
# * `index_profiles_on_address_id`:
#     * **`address_id`**
# * `index_profiles_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`address_id => addresses.id`**
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :address

  has_many :reviews, dependent: :destroy

  enum age: { '10代': 10, '20代': 20, '30代': 30, '40代': 40, '50代': 50, '60代以上': 60 }
end
