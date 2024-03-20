# ## Schema Information
#
# Table name: `cosmetic_usages`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`expiry_date`**  | `date`             | `not null`
# **`item_type`**    | `integer`          | `not null`
# **`open_date`**    | `date`             | `not null`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`user_id`**      | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_cosmetic_usages_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
class CosmeticUsage < ApplicationRecord
  belongs_to :user

  validates :item_type, presence: true
  validates :open_date, presence: true
  validates :expiry_date, presence: true

  enum item_type: { lotion: 0, serum: 1, cream: 2 }
end
