# ## Schema Information
#
# Table name: `addresses`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`address`**     | `text`             |
# **`latitude`**    | `float`            |
# **`longitude`**   | `float`            |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
class Address < ApplicationRecord
  has_many :profiles
  validates :address, uniqueness: true
end
