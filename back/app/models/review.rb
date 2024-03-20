# ## Schema Information
#
# Table name: `reviews`
#
# ### Columns
#
# Name                        | Type               | Attributes
# --------------------------- | ------------------ | ---------------------------
# **`id`**                    | `bigint`           | `not null, primary key`
# **`age`**                   | `integer`          |
# **`body`**                  | `text`             |
# **`rating`**                | `integer`          |
# **`skin_trouble`**          | `string`           |
# **`skin_type`**             | `string`           |
# **`title`**                 | `string`           |
# **`visibility`**            | `boolean`          |
# **`created_at`**            | `datetime`         | `not null`
# **`updated_at`**            | `datetime`         | `not null`
# **`favorite_cosmetic_id`**  | `bigint`           |
# **`profile_id`**            | `bigint`           |
# **`user_id`**               | `bigint`           |
#
# ### Indexes
#
# * `index_reviews_on_favorite_cosmetic_id`:
#     * **`favorite_cosmetic_id`**
# * `index_reviews_on_profile_id`:
#     * **`profile_id`**
# * `index_reviews_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`favorite_cosmetic_id => favorite_cosmetics.id`**
# * `fk_rails_...`:
#     * **`profile_id => profiles.id`**
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :favorite_cosmetic, optional: true
  belongs_to :profile, optional: true

  has_many :review_tags
  has_many :tags, through: :review_tags

  enum rating: { very_bad: 1, bad: 2, medium: 3, good: 4, very_good: 5 }
  enum age: { '10代': 10, '20代': 20, '30代': 30, '40代': 40, '50代': 50, '60代以上': 60 }
end
